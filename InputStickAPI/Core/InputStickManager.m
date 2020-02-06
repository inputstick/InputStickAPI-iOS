/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickManager.h"
#import "InputStickManager+Protected.h"
#import "InputStickManagerDelegate.h"
#import "InputStickConnectionManager.h"
#import "InputStickEncryptionManager.h"
#import "NSNotificationCenter+InputStickConnection.h"
#import "NSNotificationCenter+InputStickStatusUpdate.h"
#import "NSNotificationCenter+InputStickPacket.h"
#import "InputStickHIDBuffersManager.h"
#import "InputStickHIDBuffersManager+Protected.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickRxPacket+FirmwareInfo.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickHIDFirmwareManager.h"
#import "InputStickHIDBuffersState.h"
#import "InputStickKeyboardLEDsState.h"
#import "InputStickKeyboardHandler.h"
#import "InputStickKeyboardHandler+Protected.h"
#import "InputStickMouseHandler.h"
#import "InputStickConsumerHandler.h"
#import "InputStickTouchScreenHandler.h"
#import "InputStickGamepadHandler.h"
#import "InputStickError.h"
#import "InputStickConst.h"

@implementation InputStickManager

- (instancetype)init {
    return [self initWithSuiteName:nil];
}

- (instancetype)initWithSuiteName:(NSString *)suiteName {
    self = [super init];
    if (self) {
        _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
        _encryptionManager = [[InputStickEncryptionManager alloc] init];
        _deviceDB = [[InputStickDeviceDB alloc] initWithInputStickManager:self];
        _connectionManager = [[InputStickConnectionManager alloc] initWithInputStickManager:self];
        _firmwareManager = [[InputStickHIDFirmwareManager alloc] initWithInputStickManager:self];
        _connectionState = InputStickDisconnected;
        
        _buffersManager = [[InputStickHIDBuffersManager alloc] initWithInputStickManager:self];
        
        _keyboardHandler = [[InputStickKeyboardHandler alloc] initWithInputStickManager:self];
        _mouseHandler = [[InputStickMouseHandler alloc] initWithInputStickManager:self];
        _consumerHandler = [[InputStickConsumerHandler alloc] initWithInputStickManager:self];
        _touchScreenHandler = [[InputStickTouchScreenHandler alloc] initWithInputStickManager:self];
        _gamepadHandler = [[InputStickGamepadHandler alloc] initWithInputStickManager:self];
    }
    return self;
}


#pragma mark - InputStick Connection

- (void)resetConnection {
    [_buffersManager updateFirmwareVersion:0]; //firmware version unknown
    
    _lastError = nil;
    _lastErrorTime = 0;
    _usbState = USBDisconnected;
    _encryptionEnabled = FALSE;
    _firmwareVersion = 0;
}

- (void)connectToInputStickWithIdentifier:(NSString *)identifier {
    [self resetConnection];
    _lastConnectionAttemptMode = InputStickConnectionModeCustomDevice;
    _lastConnectionAttemptInputStickIdentifier = identifier;
    [self.connectionManager connectToPeripheralWithIdentifier:identifier orNearestStoredIfNotFound:FALSE];
}

- (void)connectToLastInputStick {
    if ([self hasStoredDeviceIdentifier]) {
        NSString *mostRecentlyUsedIdentifier = [self.deviceDB getMostRecentlyUsedDeviceIdentifier];
        if (mostRecentlyUsedIdentifier != nil) {
            [self resetConnection];
            _lastConnectionAttemptMode = InputStickConnectionModeLastDevice;
            _lastConnectionAttemptInputStickIdentifier = mostRecentlyUsedIdentifier;
            [self.connectionManager connectToPeripheralWithIdentifier:mostRecentlyUsedIdentifier orNearestStoredIfNotFound:FALSE];
        } else {
            //has devices in database, but the most recently used one was removed
            [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_APP_MOST_RECENT_DEVICE_REMOVED]];
        }
    } else {
        //no devices in database
        [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_APP_NO_DEVICES_STORED]];
    }
}

- (BOOL)autoConnectLastInputStick {
    //autoconnect will not display any errors if there is no last device stored / autoconnect failed earlier and is currently disabled
    if ([self hasStoredDeviceIdentifier]) {
        if ( ![_userDefaults boolForKey:InputStickAutoConnectFailedKey]) {
            NSString *mostRecentlyUsedIdentifier = [self.deviceDB getMostRecentlyUsedDeviceIdentifier];
            if (mostRecentlyUsedIdentifier != nil) {
                [_userDefaults setBool:TRUE forKey:InputStickAutoConnectFailedKey]; //will be set to FALSE if connects successfully
                [_userDefaults synchronize];
                
                [self resetConnection];
                _lastConnectionAttemptMode = InputStickConnectionModeAutoConnectLastDevice;
                _lastConnectionAttemptInputStickIdentifier = mostRecentlyUsedIdentifier;
                [self.connectionManager connectToPeripheralWithIdentifier:mostRecentlyUsedIdentifier orNearestStoredIfNotFound:FALSE];
                return TRUE;
            }
        }
    }
    return FALSE;
}

- (void)connectToNearsetStoredInputStick {
    if ([self hasStoredDeviceIdentifier]) {
        [self resetConnection];
        _lastConnectionAttemptMode = InputStickConnectionModeNearestDevice;
        _lastConnectionAttemptInputStickIdentifier = nil;
        [self.connectionManager connectToNearestStoredPeripheral];
    } else {
        //no devices in database
        [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_APP_NO_DEVICES_STORED]];
    }
}

- (void)retryConnectionAttempt {
    switch (_lastConnectionAttemptMode) {
        case InputStickConnectionModeCustomDevice:
            [self connectToInputStickWithIdentifier:_lastConnectionAttemptInputStickIdentifier];
            break;
        case InputStickConnectionModeLastDevice:
            [self connectToLastInputStick];
            break;
        case InputStickConnectionModeAutoConnectLastDevice:
            [self autoConnectLastInputStick];
            break;
        case InputStickConnectionModeNearestDevice:
            [self connectToNearsetStoredInputStick];
            break;
        default:
            break;
    }
}

- (void)disconnectFromInputStick {
    if (_connectionState != InputStickDisconnected) {
        [self.connectionManager disconnectFromPeripheral];
        [self setConnectionState:InputStickDisconnected];
    }
}


- (BOOL)hasStoredDeviceIdentifier {
    return (_deviceDB.numberOfStoredDevices > 0);
}

- (void)updateDevicePassword:(NSString *)password savePlainText:(BOOL)savePlainText {
    if (self.connectionManager.connected) {
        if (self.firmwareManager != nil) {
            [self.firmwareManager updateDevicePassword:password savePlainText:savePlainText];
        }
    }
}



- (BOOL)bluetoothOn {
    return self.connectionManager.bluetoothOn;
}

- (BOOL)bluetoothSupported {
    return self.connectionManager.bluetoothSupported;
}

- (BOOL)inputStickDicsonnected {
    return _connectionState == InputStickDisconnected;
}

- (BOOL)inputStickReady {
    return _connectionState == InputStickReady;
}


#pragma mark - BT scan

- (void)startBluetoothPeripheralScanWithTimeout:(BOOL)enableTimeout {
    [self.connectionManager startBluetoothPeripheralScanWithTimeout:enableTimeout];
}

- (void)stopBluetoothPeripheralScan {
    [self.connectionManager stopBluetoothPeripheralScan];
}


#pragma mark - Send Data

- (void)sendPacket:(InputStickTxPacket *)txPacket {
    if (self.connectionManager.connected) {
        [self.connectionManager sendPacket:txPacket];
    }
}


#pragma mark - Screenshot helpers

- (void)setDummyConnectedState {
    #if TARGET_IPHONE_SIMULATOR
    [self setConnectionState:InputStickReady];
    #endif
}

- (void)addDummyDevice {
    #if TARGET_IPHONE_SIMULATOR
    [self.deviceDB createDeviceWithIdentifier:@"12345678-ABCD-1234-ABCD-1234567890AB" withPreferredName:@"MyInputStick"];
    #endif
}


#pragma mark - Connected device info

- (InputStickDeviceData *)connectedInputStickDeviceData {
    if (self.connectionManager.connected) {
        return [self.deviceDB getDataForDeviceWithIdentifier:self.connectionManager.connectedPeripheral.identifier.UUIDString];
    } else {
        return nil;
    }
}

- (NSString *)connectedInputStickBluetoothName {
    if (self.connectionManager.connected) {
        return self.connectionManager.connectedPeripheral.name;
    } else {
        return nil;
    }
}

- (NSString *)connectedInputStickIdentifier {
    if (self.connectionManager.connected) {
        return self.connectionManager.connectedPeripheral.identifier.UUIDString;
    } else {
        return nil;
    }
}


#pragma mark - Protected

- (void)presentErrorDialog:(NSError *)error {
    if (self.inputStickMenuDelegate != nil) {
        [self.inputStickMenuDelegate inputStickManager:self presentErrorDialog:error];
    } else if (_delegate != nil) {
        [_delegate inputStickManager:self presentErrorDialog:error];
    }
}

- (void)presentEncryptionKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    BOOL disconnect = TRUE;
    if (self.inputStickMenuDelegate != nil) {
        if ([self.inputStickMenuDelegate inputStickManager:self presentEncryptionKeyDialog:deviceData request:request]) {
            disconnect = FALSE;
        }
    } else if (_delegate != nil) {
        if ([_delegate inputStickManager:self presentEncryptionKeyDialog:deviceData request:request]) {
            disconnect = FALSE;
        }
    }
    if (disconnect) {
        //dialog was NOT displayed -> disconnect
        switch (request) {
            case InputStickKeyRequestKeyMissing:
                [self disconnectWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_NO_KEY];
                break;
            case InputStickKeyRequestKeyChanged:
            case InputStickKeyRequestKeyInvalid:
                [self disconnectWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY];
                break;
            case InputStickKeyRequestKeyRemoved:
                [self disconnectWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED];
                break;
            default:
                [self disconnectWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_GENERAL];
                break;
        }
    }
}

- (void)presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    if (self.inputStickMenuDelegate != nil) {
        [self.inputStickMenuDelegate inputStickManager:self presentFirmwareUpdateDialog:deviceData];
    } else if (_delegate != nil) {
        [_delegate inputStickManager:self presentFirmwareUpdateDialog:deviceData];
    }
}

- (void)showErrorMessage:(NSError *)error {
    if (error != nil) {
        [self presentErrorDialog:error];
    }
}

- (void)processPacket:(InputStickRxPacket *)rxPacket {
    [_firmwareManager processPacket:rxPacket];
    if (rxPacket.command == CmdHIDStatusNotification) {
        InputStickHIDBuffersState *buffersState = [[InputStickHIDBuffersState alloc] initWithInputStickRxPacket:rxPacket];
        [_buffersManager updateBuffersState:buffersState];
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickHIDBuffersStateWithModel:buffersState];
        
        InputStickKeyboardLEDsState *ledsState = [[InputStickKeyboardLEDsState alloc] initWithInputStickRxPacket:rxPacket];
        if (_keyboardHandler.keyboardLEDsState.rawValue != ledsState.rawValue) {
            [_keyboardHandler setKeyboardLEDsState:ledsState];
            [[NSNotificationCenter defaultCenter] postDidUpdateInputStickKeyboardLEDsWithValue:ledsState];
        }
    }
    if (rxPacket.command == CmdGetFirmwareInfo) {
        //important! DeviceInfo must be updated by FirmwareManager!
        _firmwareVersion = rxPacket.firmwareVersion;
        [_buffersManager updateFirmwareVersion:_firmwareVersion];
    }
    [[NSNotificationCenter defaultCenter] postDidReceiveInputStickPacket:rxPacket];
}

//request disconnect due to an error
- (void)disconnectWithErrorCode:(InputStickErrorCode)errorCode {
    if (_connectionState != InputStickDisconnected) {
        [self.connectionManager disconnectFromPeripheral]; //will not cause didDisconnect callback
        [self didDisconnect:errorCode];
    }
}

//connection manager notifies us that connection has been lost/failed
- (void)didDisconnect:(InputStickErrorCode)errorCode {
    _lastError = [InputStickError getNSErrorWithCode:errorCode];
    _lastErrorTime = [[NSDate date] timeIntervalSince1970];
    [self setConnectionState:InputStickDisconnected];
    if (_lastError != nil) {
        [self presentErrorDialog:_lastError];
    }
}

- (void)setConnectionState:(InputStickConnectionState)connectionState {
    if (_connectionState != connectionState) {
        _connectionState = connectionState;        
        switch (_connectionState) {
            case InputStickDisconnected:
                [_firmwareManager reset];
            case InputStickConnecting:
                _usbState = USBDisconnected;
                break;
            case InputStickInitializing:
                _usbState = USBDisconnected;
                [_firmwareManager startInitialization];
                break;
            case InputStickWaitingForUSB:
                break;
            case InputStickReady:
                [self reEnableAutoConnect];
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickConnectionState:[NSNumber numberWithUnsignedInteger:_connectionState]
                                                                           errorCode:[NSNumber numberWithInteger:_lastError.code]];
    }
}

- (void)setUSBState:(InputStickUSBState)state {
    _usbState = state;
}

- (void)setEncryptionStatus:(BOOL)enabled {
    _encryptionEnabled = enabled;
}


- (void)setFirmwareManager:(id<InputStickFirmwareManagerProtocol>)firmwareManager {
    _firmwareManager = firmwareManager;
    if (self.inputStickReady) {
        [_firmwareManager startInitialization];
    }
}


- (InputStickDeviceData *)addConectedDeviceToDatabase {
    if (self.connectionManager.connected) {
        CBPeripheral *peripheral = self.connectionManager.connectedPeripheral;
        [self.deviceDB createDeviceWithIdentifier:peripheral.identifier.UUIDString withPreferredName:peripheral.name];
        return [self.deviceDB getDataForDeviceWithIdentifier:peripheral.identifier.UUIDString];
    } else {
        return nil;
    }
}

- (void)reEnableAutoConnect {
    [_userDefaults setBool:FALSE forKey:InputStickAutoConnectFailedKey]; //set to FALSE after successfull connection
    [_userDefaults synchronize];
}

@end
