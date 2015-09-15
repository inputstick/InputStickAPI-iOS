/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDeviceSelectionViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISConnectionManager.h"
#import "TxPacket.h"


NSString *const InputStickStoredIdentifierKey = @"InputStickStoredIdentifier";
NSString *ISErrorDomain = @"InputStickErrorDomain";


@interface ISConnectionManager ()
@property(nonatomic, strong) NSTimer *connectionTimeoutTimer;
@end

@implementation ISConnectionManager

#pragma mark - Object lifecycle

- (instancetype)initWithManager:(ISManager *)manager deviceStatusProvider:(ISDeviceStatusProvider *)deviceStatusProvider {
    self = [super init];
    if (self) {
        _manager = manager;
        _deviceStatusProvider = deviceStatusProvider;
        _bluetoothCentralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                                        queue:dispatch_get_main_queue()];
        self.foundPeripherals = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] registerForConnectionNotificationsWithObserver:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromConnectionNotificationsWithObserver:self];
}

#pragma mark - Interface methods

- (void)connectToPeripheralWithIdentifier:(NSString *)identifier {
    self.selectedDeviceIdentifier = identifier;
    CBPeripheral *targetPeripheral = [self peripheralWithIdentifier:identifier];
    if (targetPeripheral) {
        [self connectToPeripheral:targetPeripheral];
    }
}

- (void)connectToPeripheral:(CBPeripheral *)peripheral {
    [[NSNotificationCenter defaultCenter] postWillStartConnectingToPeripheralNotificationWithConnectionManager:self];
    self.selectedDeviceIdentifier = [peripheral.identifier UUIDString];
    peripheral.delegate = self;
    [self.bluetoothCentralManager connectPeripheral:peripheral
                                            options:nil];
}

- (void)disconnectCurrentDevice {
    if (self.connectedPeripheral) {
        [self.bluetoothCentralManager cancelPeripheralConnection:self.connectedPeripheral];
        _connectedPeripheral = nil;
        _discoveredCharacteristic = nil;
    }
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSString *messageToShow;

    switch (central.state) {
        case CBCentralManagerStateUnknown: {
            messageToShow = @"State unknown, update imminent.";
            break;
        }
        case CBCentralManagerStateResetting: {
            messageToShow = [NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            break;
        }
        case CBCentralManagerStateUnsupported: {
            messageToShow = [NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStateUnauthorized: {
            messageToShow = [NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStatePoweredOff: {
            messageToShow = [NSString stringWithFormat:@"Bluetooth is currently powered off."];
            break;
        }
        case CBCentralManagerStatePoweredOn: {
            messageToShow = [NSString stringWithFormat:@"Bluetooth is currently powered on and available to use."];

            NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @NO};
            [self.bluetoothCentralManager scanForPeripheralsWithServices:nil
                                                                 options:options];
            break;
        }
    }
    NSLog(messageToShow);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *identifiersArray = [self.foundPeripherals valueForKeyPath:@"identifier"];
    if ([identifiersArray containsObject:peripheral.identifier]) {
        return;
    }
    [self.foundPeripherals addObject:peripheral];
    if ([self.selectedDeviceIdentifier isEqualToString:[peripheral.identifier UUIDString]]) {
        [self connectToPeripheral:peripheral];
    }
    [[NSNotificationCenter defaultCenter] postDidUpdatePeripheralsListNotificationWithConnectionManager:self];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
    [[NSNotificationCenter defaultCenter] postDidDisconnectInputStickNotificationWithConnectionManager:nil];
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        [[NSNotificationCenter defaultCenter] postDidFinishConnectingToPeripheralNotificationWithConnectionManager:self
                                                                                                         withError:error];
    } else {
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        [[NSNotificationCenter defaultCenter] postDidFinishConnectingToPeripheralNotificationWithConnectionManager:self
                                                                                                         withError:error];
    } else {
        for (CBCharacteristic *characteristic in service.characteristics) {
            [peripheral discoverDescriptorsForCharacteristic:characteristic];
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        _connectedPeripheral = peripheral;
        _discoveredCharacteristic = characteristic;
    }
    [[NSNotificationCenter defaultCenter] postDidFinishConnectingToPeripheralNotificationWithConnectionManager:self
                                                                                                     withError:error];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    [self.deviceStatusProvider parseResponseBytes:characteristic.value.bytes withLength:characteristic.value.length];
}

#pragma mark - ConnectionNotificationObserver

- (void)didFinishConnectingPeripheral:(NSNotification *)notification {
    NSError *connectionError = notification.userInfo[@"error"];
    if (connectionError) {
        NSLog(@"Unable to connect to Bluetooth device");
        return;
    }
    TxPacket *runFirmwarePacket = [[TxPacket alloc] initWithPacketType:PacketTypeRunFirmware];
    runFirmwarePacket.requiresResponse = YES;
    [self.manager sendData:runFirmwarePacket.dataBytes];

    self.connectionTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                                 selector:@selector(inputStickConnectionTimeout)
                                                                 userInfo:nil
                                                                  repeats:NO];
}

- (void)didFinishConnectingInputStick:(NSNotification *)notification {
    if (self.connectionTimeoutTimer) {
        [self.connectionTimeoutTimer invalidate];
        self.connectionTimeoutTimer = nil;
    }
}

- (void)inputStickConnectionTimeout {
    NSString *localizedDescriptionText = [NSString stringWithFormat:@"The bluetooth device didn't respond in an expected fassion for 1 second after establishing a connection."];
    NSError *error = [[NSError alloc] initWithDomain:ISErrorDomain
                                                code:ISConnectionTimeoutErrorCode
                                            userInfo:@{NSLocalizedDescriptionKey : localizedDescriptionText}];
    [[NSNotificationCenter defaultCenter] postDidFinishConnectingInputStickNotificationWithConnectionManager:self
                                                                                                   withError:error];
}

#pragma mark - Helpers

- (CBPeripheral *)peripheralWithIdentifier:(NSString *)identifierString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier.UUIDString = %@", identifierString];
    CBPeripheral *foundPeripheral = [[self.foundPeripherals filteredArrayUsingPredicate:predicate] firstObject];
    return foundPeripheral;
}

#pragma mark - Static Methods

+ (NSString *)inputStickDeviceIdentifier {
    return [[NSUserDefaults standardUserDefaults] valueForKey:InputStickStoredIdentifierKey];
}

+ (void)setInputStickDeviceIdentifier:(NSString *)identifier {
    [[NSUserDefaults standardUserDefaults] setValue:identifier forKey:InputStickStoredIdentifierKey];
}

@end
