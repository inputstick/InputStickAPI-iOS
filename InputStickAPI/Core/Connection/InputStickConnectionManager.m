/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickConnectionManager.h"
#import "InputStickManager.h"
#import "InputStickManager+Protected.h"
#import "InputStickEncryptionManager.h"
#import "InputStickPacketParser.h"
#import "InputStickTxPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickPacket.h"
#import "InputStickFirmwareManagerProtocol.h"
#import "InputStickPeripheralInfo.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickError.h"
#import "InputStickConst.h"

//values in seconds
static NSUInteger const ConnectionTimeoutPeriod = 5;
static NSUInteger const PeripheralScanTimeoutPeriod = 15;
static NSUInteger const LastSeenCheckInterval = 2;
static NSUInteger const LastSeenThreshold = 5;


@interface InputStickConnectionManager () {
    NSTimer *_connectionTimeoutTimer;
    NSTimer *_scanTimeoutTimer;
    NSTimer *_outOfRangeTimer;
    NSTimer *_lastSeenTimeCheckTimer;
    CBPeripheral *_tmpPeripheral;
    BOOL _connectNearestStoredDeviceOnFailure;
    NSString *_identifierToConnectTo;
    
    InputStickPacketParser *_packetParser;
}

@end


@implementation InputStickConnectionManager

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager {
    self = [super init];
    if (self) {
        _bluetoothSupported = TRUE;
        _bluetoothOn = FALSE;
        
        _inputStickManager = inputStickManager;
        _bluetoothCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        _foundPeripherals = [NSMutableArray array];
        
        _packetParser = [[InputStickPacketParser alloc] initWithInputStickManager:inputStickManager];
    }
    return self;
}


#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //NSString *messageToShow;
    switch (central.state) {
        case CBManagerStateUnknown: {
            //messageToShow = @"State unknown, update imminent.";
            break;
        }
        case CBManagerStateResetting: {
            _bluetoothOn = FALSE;
            //messageToShow = [NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            [self clearFoundPeripheralsArray];
            break;
        }
        case CBManagerStateUnsupported: {
            _bluetoothSupported = FALSE;
            //messageToShow = [NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBManagerStateUnauthorized: {
            _bluetoothOn = FALSE;
            //messageToShow = [NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            [self clearFoundPeripheralsArray];
            break;
        }
        case CBManagerStatePoweredOff: {
            _bluetoothOn = FALSE;
            //messageToShow = [NSString stringWithFormat:@"Bluetooth is currently powered off."];
            [self clearFoundPeripheralsArray];
            if (_connectedPeripheral != nil) {
                _connectedPeripheral = nil;
                [self failedWithErrorCode:INPUTSTICK_ERROR_BT_TURNED_OFF];
            }
            break;
        }
        case CBManagerStatePoweredOn: {
            _bluetoothOn = TRUE;
            /*
             //start scan only if the app was already used with InputStick (= user can potentially use it again)
             if (self.inputStickManager.autoStartScanOnStartup && [self.inputStickManager hasStoredDeviceIdentifier]) {
             [self startBluetoothPeripheralScanWithTimeout:TRUE];
             }*/
            break;
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSNumber *timeInSeconds = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    NSString *uuid = [peripheral.identifier UUIDString];
    NSArray<NSString *> *identifiersArray = [self.foundPeripherals valueForKeyPath:@"identifier"];
    NSUInteger index = [identifiersArray indexOfObject:uuid];
    //RSSI can be updated only for connected peripheral -> scan continuously
    InputStickPeripheralInfo *peripheralInfo;
    BOOL notify = FALSE;
    if (index != NSNotFound) {
        peripheralInfo = [self.foundPeripherals objectAtIndex:index];
        //send notification if name has been assigned or changed
        if (peripheral.name != nil) {
            if (peripheralInfo.name == nil) {
                notify = TRUE;
            } else {
                if ( ![peripheralInfo.name isEqualToString:peripheral.name]) {
                    notify = TRUE;
                }
            }
            peripheralInfo.name = [peripheral.name copy];
        }
        
    } else {
        peripheralInfo = [[InputStickPeripheralInfo alloc] init];
        peripheralInfo.peripheral = peripheral;
        peripheralInfo.identifier = uuid;
        peripheralInfo.name = [peripheral.name copy];
        [self.foundPeripherals addObject:peripheralInfo];
        notify = TRUE;
    }
    
    if (notify) {
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickPeripheralsList:self.foundPeripherals];
    }
    
    peripheralInfo.lastSeenTime = [timeInSeconds integerValue];
    peripheralInfo.rssi = [RSSI integerValue];
    if ((_outOfRangeTimer != nil) && ([_identifierToConnectTo isEqualToString:uuid])) {
        [self invalidateOutOfRangeTimer];
        [self connectToPeripheral:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [self stopBluetoothPeripheralScan];
    [_packetParser resetRxState];
    _connectedPeripheral = peripheral;
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    _connectedPeripheral = nil;
    if (error != nil) {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_CONNECTION_LOST];
    }
}


#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_SERVICE];
    } else {
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_CHARACTERISTIC];
    } else {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if ([characteristic.UUID.UUIDString caseInsensitiveCompare:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"] == NSOrderedSame) {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            if ([characteristic.UUID.UUIDString caseInsensitiveCompare:@"FFE1"] == NSOrderedSame) {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
            [peripheral discoverDescriptorsForCharacteristic:characteristic];
            
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_DESCRIPTOR];
    } else {
        if ([characteristic.UUID.UUIDString caseInsensitiveCompare:@"FFE1"] == NSOrderedSame) {
            _characteristicRx = characteristic;
            _characteristicTx = characteristic;
        }
        if ([characteristic.UUID.UUIDString caseInsensitiveCompare:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"] == NSOrderedSame) {
            _characteristicRx = characteristic;
        }
        if ([characteristic.UUID.UUIDString caseInsensitiveCompare:@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"] == NSOrderedSame) {
            _characteristicTx = characteristic;
        }
        if (_characteristicRx && _characteristicTx) {
            [self invalidateConnectionTimeoutTimer];
            [self.inputStickManager setConnectionState:InputStickInitializing];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_CHARACTERISTIC_VALUE];
    } else {
        [self receiveBytes:(Byte *)characteristic.value.bytes withLength:characteristic.value.length];
    }
}


#pragma mark - Connection-related methods

- (BOOL)connected {
    return (_connectedPeripheral && _characteristicRx);
}

- (void)connectToPeripheralWithIdentifier:(NSString *)identifier orNearestStoredIfNotFound:(BOOL)allowNearestStored {
    if (identifier == nil) {
        return;
    }
    
    [self startBluetoothPeripheralScanWithTimeout:TRUE]; //required or will not connect (unless scan was manually initiated before)
    _identifierToConnectTo = nil;
    _connectNearestStoredDeviceOnFailure = allowNearestStored;
    CBPeripheral *peripheral = [self peripheralWithIdentifier:identifier];
    if (_bluetoothSupported) {
        if (_bluetoothOn) {
            if (peripheral) {
                [self connectToPeripheral:peripheral];
            } else {
                //device not discovered/out or range/unplugged, scan for a few more seconds before displaying error message
                _identifierToConnectTo = identifier;
                [self.inputStickManager setConnectionState:InputStickConnecting]; //trying to establish connection, this may take up to CONNECTION_TIMEOUT_PERIOD seconds
                [self startOutOfRangeTimer];
            }
        } else {
            [self failedWithErrorCode:INPUTSTICK_ERROR_BT_TURNED_OFF];
        }
    } else {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_NOT_SUPPORTED];
    }
}

- (void)connectToNearestStoredPeripheral {
    [self startBluetoothPeripheralScanWithTimeout:TRUE]; //required or will not connect (unless scan was manually initiated before)
    _connectNearestStoredDeviceOnFailure = TRUE;
    if (_bluetoothSupported) {
        if (_bluetoothOn) {
            [self.inputStickManager setConnectionState:InputStickConnecting]; //trying to establish connection, this may take up to CONNECTION_TIMEOUT_PERIOD seconds
            [self startOutOfRangeTimer];
        } else {
            [self failedWithErrorCode:INPUTSTICK_ERROR_BT_TURNED_OFF];
        }
    } else {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_NOT_SUPPORTED];
    }
}

- (void)connectToPeripheral:(CBPeripheral *)peripheral {
    _identifierToConnectTo = nil;
    _tmpPeripheral = peripheral;
    [self startConnectionTimeoutTimer];
    [self.inputStickManager setConnectionState:InputStickConnecting];
    peripheral.delegate = self;
    [self.bluetoothCentralManager connectPeripheral:peripheral options:nil];
}


- (void)disconnectFromPeripheral {
    [self invalidateConnectionTimeoutTimer];
    [self invalidateOutOfRangeTimer];
    if (self.connectedPeripheral) {
        //disconnect action
        [self.bluetoothCentralManager cancelPeripheralConnection:self.connectedPeripheral];
        _connectedPeripheral = nil;
        _characteristicRx = nil;
        _characteristicTx = nil;
    } else if (_tmpPeripheral) {
        //cancel connection attempt action
        [self.bluetoothCentralManager cancelPeripheralConnection:_tmpPeripheral];
        _tmpPeripheral = nil;
        _characteristicRx = nil;
        _characteristicTx = nil;
    } else {
        _connectedPeripheral = nil;
        _tmpPeripheral = nil;
        _characteristicRx = nil;
        _characteristicTx = nil;
    }
}

- (void)failedWithErrorCode:(InputStickErrorCode)errorCode {
    [self disconnectFromPeripheral]; //clean up
    [self.inputStickManager didDisconnect:errorCode];
}


#pragma mark - BT scan

- (void)startBluetoothPeripheralScanWithTimeout:(BOOL)enableTimeout {
    [self invalidateScanTimeoutTimer];
    if (enableTimeout) {
        [self startScanTimeoutTimer];
    }
    
    if ( ![self.bluetoothCentralManager isScanning]) {
        [self clearFoundPeripheralsArray];
        NSArray<CBUUID *> *uuidArray = [NSArray arrayWithObjects:
                                        [CBUUID UUIDWithString:@"0000ffe0-0000-1000-8000-00805f9b34fb"],
                                        [CBUUID UUIDWithString:@"6e400001-b5a3-f393-e0a9-e50e24dcca9e"],
                                        nil];
        NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES};
        [self.bluetoothCentralManager scanForPeripheralsWithServices:uuidArray options:options];
        _lastSeenTimeCheckTimer = [NSTimer scheduledTimerWithTimeInterval:LastSeenCheckInterval target:self selector:@selector(lastSeenTimeCheck) userInfo:nil repeats:YES];
        [[NSNotificationCenter defaultCenter] postDidStartInputStickPeripheralScan];
    }
}

- (void)stopBluetoothPeripheralScan {
    BOOL notify = [self.bluetoothCentralManager isScanning];
    [self invalidateScanTimeoutTimer];
    [_lastSeenTimeCheckTimer invalidate];
    //[self clearFoundPeripheralsArray];
    [self.bluetoothCentralManager stopScan];
    if (notify) {
        [[NSNotificationCenter defaultCenter] postDidFinishInputStickPeripheralScan];
    }
}

- (void)lastSeenTimeCheck {
    NSInteger threshold = [[NSDate date] timeIntervalSince1970] - LastSeenThreshold;
    
    NSMutableArray<InputStickPeripheralInfo *> *toRemove = [NSMutableArray array];
    InputStickPeripheralInfo *peripheralInfo;
    for (int i = 0; i < [self.foundPeripherals count]; i++) {
        peripheralInfo = [self.foundPeripherals objectAtIndex:i];
        if (peripheralInfo.lastSeenTime < threshold) {
            [toRemove addObject:peripheralInfo];
        }
    }
    
    if ([toRemove count] > 0) {
        [self.foundPeripherals removeObjectsInArray:toRemove];
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickPeripheralsList:self.foundPeripherals];
    }
}

- (BOOL)hasDeviceBeenDiscovered:(NSString *)identifier {
    if (identifier == nil) {
        return FALSE;
    }
    CBPeripheral *targetPeripheral = [self peripheralWithIdentifier:identifier];
    if (targetPeripheral) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)clearFoundPeripheralsArray {
    [self.foundPeripherals removeAllObjects];
    [[NSNotificationCenter defaultCenter] postDidUpdateInputStickPeripheralsList:self.foundPeripherals];
}


#pragma mark - Timeout

- (void)startConnectionTimeoutTimer {
    _connectionTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:ConnectionTimeoutPeriod target:self selector:@selector(connectionTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)invalidateConnectionTimeoutTimer {
    if (_connectionTimeoutTimer) {
        [_connectionTimeoutTimer invalidate];
        _connectionTimeoutTimer = nil;
    }
}

- (void)connectionTimeoutEvent {
    _connectionTimeoutTimer = nil;
    [self failedWithErrorCode:INPUTSTICK_ERROR_BT_CONNECTION_TIMEDOUT];
}

- (void)startScanTimeoutTimer {
    _scanTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:PeripheralScanTimeoutPeriod target:self selector:@selector(scanTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)invalidateScanTimeoutTimer {
    if (_scanTimeoutTimer) {
        [_scanTimeoutTimer invalidate];
        _scanTimeoutTimer = nil;
    }
}

- (void)scanTimeoutEvent {
    _scanTimeoutTimer = nil;
    [self stopBluetoothPeripheralScan];
    [[NSNotificationCenter defaultCenter] postDidTimeoutInputStickPeripheralScan];
}

- (void)startOutOfRangeTimer {
    _outOfRangeTimer = [NSTimer scheduledTimerWithTimeInterval:ConnectionTimeoutPeriod target:self selector:@selector(outOfRangeEvent) userInfo:nil repeats:NO];
}

- (void)invalidateOutOfRangeTimer {
    [_outOfRangeTimer invalidate];
    _outOfRangeTimer = nil;
    _identifierToConnectTo = nil;
    _connectNearestStoredDeviceOnFailure = FALSE;
}

- (void)outOfRangeEvent {
    _outOfRangeTimer = nil;
    _identifierToConnectTo = nil;
    if (_connectNearestStoredDeviceOnFailure) {
        //find known device with strongest RSSI
        InputStickPeripheralInfo *closestPeripheral = nil;
        for (InputStickPeripheralInfo *peripheralInfo in self.foundPeripherals) {
            if ([self.inputStickManager.deviceDB hasDeviceWithIdentifier:peripheralInfo.identifier]) {
                if (closestPeripheral == nil) {
                    closestPeripheral = peripheralInfo;
                } else {
                    if (peripheralInfo.rssi > closestPeripheral.rssi) {
                        closestPeripheral = peripheralInfo;
                    }
                }
            }
        }
        
        if (closestPeripheral == nil) {
            [self failedWithErrorCode:INPUTSTICK_ERROR_BT_OUT_OF_RANGE];
        } else {
            [self connectToPeripheralWithIdentifier:closestPeripheral.identifier orNearestStoredIfNotFound:FALSE];
        }
    } else {
        [self failedWithErrorCode:INPUTSTICK_ERROR_BT_OUT_OF_RANGE];
    }
}


#pragma mark - Send/Receive data

- (void)sendPacket:(InputStickTxPacket *)txPacket {
    if ( !self.connected) {
        //Attempted to send data without an active connection to InputStick device
        return;
    }
    
    BOOL encrypt = FALSE;
    BOOL addHMAC = FALSE;
    
    if (self.inputStickManager.encryptionEnabled) {
        if ([InputStickPacket canEncrypt:txPacket.command]) {
            encrypt = TRUE;
            if ([self.inputStickManager.encryptionManager hmacEnabled]) {
                addHMAC = [InputStickPacket requiresHMAC:txPacket.command];
            }
        }
    }

    NSData *packetData = [txPacket getPacketData];
    NSMutableData *headerData = [[NSMutableData alloc] initWithLength:2];
    Byte *headerBytes = (Byte *)headerData.bytes;
    NSData *hmacData = nil;
    
    //header
    headerBytes[0] = 0x55;
    headerBytes[1] = ([packetData length] / 16);
    //header flags:
    if (addHMAC) {
        headerBytes[1] |= InputStickPacketFlagHMAC;
    }
    if (encrypt) {
        headerBytes[1] |= InputStickPacketFlagEncrypted;
    }
    if (txPacket.requiresResponse) {
        headerBytes[1] |= InputStickPacketFlagResponse;
    }
    //encrypt?
    if (encrypt) {
        packetData = [self.inputStickManager.encryptionManager encryptData:packetData];
        //add HMAC to packet
        if (addHMAC) {
            hmacData = [self.inputStickManager.encryptionManager getHMACForData:packetData];
        }
    }
    
    NSMutableData *rawData = [[NSMutableData alloc] initWithData:headerData];
    [rawData appendData:packetData];
    [rawData appendData:hmacData];
    [self sendData:rawData];
}

- (void)sendData:(NSData *)data {
    NSUInteger totalLength = [data length];
    NSUInteger maxWriteLength = [_connectedPeripheral maximumWriteValueLengthForType:CBCharacteristicWriteWithoutResponse];
    if (totalLength > maxWriteLength) {
        //split data to match BLE packet length
        NSUInteger start = 0;
        NSUInteger length;
        while(start < totalLength) {
            length = (start + maxWriteLength > totalLength) ? totalLength - start : maxWriteLength;
            [_connectedPeripheral writeValue:[data subdataWithRange:NSMakeRange(start, length)]
                           forCharacteristic:_characteristicTx
                                        type:CBCharacteristicWriteWithoutResponse];
            start += length;
        }
    } else {
        [_connectedPeripheral writeValue:data
                       forCharacteristic:_characteristicTx
                                    type:CBCharacteristicWriteWithoutResponse];
    }
}

- (void)receiveBytes:(Byte *)bytes withLength:(NSUInteger)length {
    for (int i = 0; i < length; i++) {
        InputStickPacketParsingResult result = [_packetParser parseResponseByte:bytes[i]];
        if (result == InputStickPacketParsingResultDone) {
            InputStickRxPacket *rxPacket = _packetParser.parsedPacket;
            [self.inputStickManager processPacket:rxPacket];
        }
        if (result == InputStickPacketParsingResultError) {
            [self failedWithErrorCode:_packetParser.errorCode];
        }
    }
}


#pragma mark - Helpers

- (CBPeripheral *)peripheralWithIdentifier:(NSString *)identifierString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifierString];
    InputStickPeripheralInfo *foundPeripheralInfo = [[self.foundPeripherals filteredArrayUsingPredicate:predicate] firstObject];
    return foundPeripheralInfo.peripheral;
}


@end
