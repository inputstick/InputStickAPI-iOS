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
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransactionBuffer+Protected.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"
#import "InputStickRxPacket.h"
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

@interface InputStickManager () {
    BOOL _runManualSelectionOnOutOfRangeError; //TODO remove!
    //HID report buffers
    InputStickHIDTransactionBuffer *_keyboardBuffer;
    InputStickHIDTransactionBuffer *_mouseBuffer;
    InputStickHIDTransactionBuffer *_consumerBuffer;
}

@end


@implementation InputStickManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _keyboardBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:self withHIDInterface:InputStickHIDInterfaceKeyboard];
        _mouseBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:self withHIDInterface:InputStickHIDInterfaceMouse];
        _consumerBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:self withHIDInterface:InputStickHIDInterfaceConsumer];
        
        _encryptionManager = [[InputStickEncryptionManager alloc] init];        
        _deviceDB = [[InputStickDeviceDB alloc] init];
        _connectionManager = [[InputStickConnectionManager alloc] initWithInputStickManager:self];
        _firmwareManager = [[InputStickHIDFirmwareManager alloc] initWithInputStickManager:self];
        _connectionState = InputStickDisconnected;
        
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
    //reset buffers and set parameters supported by all firmware versions:
    [_keyboardBuffer setupWithCapacity:32 maxReportsPerPacket:32];
    [_mouseBuffer setupWithCapacity:32 maxReportsPerPacket:32];
    [_consumerBuffer setupWithCapacity:32 maxReportsPerPacket:32];
    
    _lastError = nil;
    _lastErrorTime = 0;
    _runManualSelectionOnOutOfRangeError = FALSE;
    _usbState = USBDisconnected;
    _encryptionEnabled = FALSE;
    _firmwareVersion = 0;
}

- (void)connectToInputStickWithIdentifier:(NSString *)identifier {
    [self resetConnection];
    [self.connectionManager connectToPeripheralWithIdentifier:identifier orNearestStoredIfNotFound:FALSE];
}

- (void)connectToLastInputStick {
    [self resetConnection];
    if ([self hasStoredDeviceIdentifier]) {
        NSString *mostRecentlyUsedIdentifier = [self.deviceDB getMostRecentlyUsedDeviceIdentifier];
        if (mostRecentlyUsedIdentifier == nil) {
            //has devices in database, but the most recently used one was removed
            [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_IOS_MOST_RECENT_DEVICE_REMOVED]];
        } else {
            [self.connectionManager connectToPeripheralWithIdentifier:mostRecentlyUsedIdentifier orNearestStoredIfNotFound:FALSE];
        }
    } else {
        //no devices in database
        [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED]];
    }
}

- (void)connectToNearsetStoredInputStick {
    [self resetConnection];
    if ([self hasStoredDeviceIdentifier]) {
        [self.connectionManager connectToNearestStoredPeripheral];
    } else {
        //no devices in database
        [self showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED]];
    }
}

- (BOOL)autoConnectLastInputStick {
    //autoconnect will not display any errors if there is no last device stored / autoconnect failed earlier and is currently disabled
    if ([self hasStoredDeviceIdentifier]) {
        if ( ![[NSUserDefaults standardUserDefaults] boolForKey:InputStickAutoConnectFailedKey]) {
            [self resetConnection];
            [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:InputStickAutoConnectFailedKey]; //will be set to FALSE if connects successfully
            [self.connectionManager connectToPeripheralWithIdentifier:[self.deviceDB getMostRecentlyUsedDeviceIdentifier] orNearestStoredIfNotFound:FALSE];
            return TRUE;
        }
    }
    return FALSE;
}

- (void)disconnectFromInputStick {
    [self.connectionManager disconnectCurrentDeviceWithErrorCode:INPUTSTICK_ERROR_NONE];
}


- (BOOL)hasStoredDeviceIdentifier {
    return (_deviceDB.numberOfStoredDevices > 0);
}

- (void)updateDevicePassword:(NSString *)password {
    if (self.connectionManager.connected) {
        if (self.firmwareManager != nil) {
            [self.firmwareManager updateDevicePassword:password];
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


#pragma mark - HID Buffers

- (BOOL)allBuffersEmpty {
    return ([self keyboardBufferEmpty] && [self mouseBufferEmpty] && [self consumerBufferEmpty]);
}

- (void)clearHIDBuffers {
    [_keyboardBuffer clear];
    [_mouseBuffer clear];
    [_consumerBuffer clear];
    if (_firmwareVersion >= 100) {
        if (( !_keyboardBuffer.bufferEmpty) || ( !_mouseBuffer.bufferEmpty) || ( !_consumerBuffer.bufferEmpty)) {
            InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x07];
            [self sendPacket:packet];
        }
    }
}


#pragma mark - HID Keyboard Buffer

- (BOOL)keyboardBufferEmpty {
    return _keyboardBuffer.bufferEmpty;
}

- (BOOL)keyboardLocalBufferEmpty {
    return _keyboardBuffer.localBufferEmpty;
}

- (void)clearKeyboardBuffer {
    [_keyboardBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_keyboardBuffer.bufferEmpty)) { 
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x01];
        [self sendPacket:packet];
    }
}

- (void)clearKeyboardLocalBuffer {
    [_keyboardBuffer clear];
}

- (void)addKeyboardHIDReport:(InputStickHIDReport *)report sendASAP:(BOOL)sendASAP {
    [_keyboardBuffer addHIDReport:report sendASAP:sendASAP];
}

- (void)addKeyboardHIDTransaction:(InputStickHIDTransaction *)transaction sendASAP:(BOOL)sendASAP {
    [_keyboardBuffer addHIDTransaction:transaction sendASAP:sendASAP];
}

- (void)flushKeyboardBuffer {
    [_keyboardBuffer sendFromQueue];
}


#pragma mark - HID Mouse Buffer

- (BOOL)mouseBufferEmpty {
    return _mouseBuffer.bufferEmpty;
}

- (BOOL)mouseLocalBufferEmpty {
    return _mouseBuffer.localBufferEmpty;
}

- (void)clearMouseBuffer {
    [_mouseBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_mouseBuffer.bufferEmpty)) {
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x02];
        [self sendPacket:packet];
    }
}

- (void)clearMouseLocalBuffer {
    [_mouseBuffer clear];
}

- (void)addMouseHIDReport:(InputStickHIDReport *)report sendASAP:(BOOL)sendASAP {
    [_mouseBuffer addHIDReport:report sendASAP:sendASAP];
}

- (void)addMouseHIDTransaction:(InputStickHIDTransaction *)transaction sendASAP:(BOOL)sendASAP {
    [_mouseBuffer addHIDTransaction:transaction sendASAP:sendASAP];
}

- (void)flushMouseBuffer {
    [_mouseBuffer sendFromQueue];
}


#pragma mark - HID Consumer Buffer

- (BOOL)consumerBufferEmpty {
    return _consumerBuffer.bufferEmpty;
}

- (BOOL)consumerLocalBufferEmpty {
    return _consumerBuffer.localBufferEmpty;
}

- (void)clearConsumerBuffer {
    [_consumerBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_consumerBuffer.bufferEmpty)) {
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x04];
        [self sendPacket:packet];
    }
}

- (void)clearConsumerLocalBuffer {
    [_consumerBuffer clear];
}

- (void)addConsumerHIDReport:(InputStickHIDReport *)report sendASAP:(BOOL)sendASAP {
    [_consumerBuffer addHIDReport:report sendASAP:sendASAP];
}

- (void)addConsumerHIDTransaction:(InputStickHIDTransaction *)transaction sendASAP:(BOOL)sendASAP {
    [_consumerBuffer addHIDTransaction:transaction sendASAP:sendASAP];
}

- (void)flushConsumerBuffer {
    [_consumerBuffer sendFromQueue];
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

- (void)presentKeyRemovedDialog:(InputStickDeviceData *)deviceData {
    if (self.inputStickMenuDelegate != nil) {
        [self.inputStickMenuDelegate inputStickManager:self presentKeyRemovedDialog:deviceData];
    } else if (_delegate != nil) {
        [_delegate inputStickManager:self presentKeyRemovedDialog:deviceData];
    }
}

- (void)presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    if (self.inputStickMenuDelegate != nil) {
        [self.inputStickMenuDelegate inputStickManager:self presentProvideKeyDialog:deviceData request:request];
    } else if (_delegate != nil) {
        [_delegate inputStickManager:self presentProvideKeyDialog:deviceData request:request];
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
        _lastError = error;
        _lastErrorTime = [[NSDate date] timeIntervalSince1970];
        [self presentErrorDialog:error];
    }
}

- (void)processPacket:(InputStickRxPacket *)rxPacket {
    [_firmwareManager processPacket:rxPacket];
    if (rxPacket.command == CmdHIDStatusNotification) {
        InputStickHIDBuffersState *buffersState = [[InputStickHIDBuffersState alloc] initWithInputStickRxPacket:rxPacket];
        [_keyboardBuffer updateWithNumberOfReportsSentToHost:buffersState.keyboardReportsSentToHost isEmpty:buffersState.keyboardBufferEmpty];
        [_mouseBuffer updateWithNumberOfReportsSentToHost:buffersState.mouseReportsSentToHost isEmpty:buffersState.mouseBufferEmpty];
        [_consumerBuffer updateWithNumberOfReportsSentToHost:buffersState.consumerReportsSentToHost isEmpty:buffersState.consumerBufferEmpty];
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickHIDBuffersStateWithModel:buffersState];
        
        InputStickKeyboardLEDsState *ledsState = [[InputStickKeyboardLEDsState alloc] initWithInputStickRxPacket:rxPacket];
        if (_keyboardHandler.keyboardLEDsState.rawValue != ledsState.rawValue) {
            [_keyboardHandler setKeyboardLEDsState:ledsState];
            [[NSNotificationCenter defaultCenter] postDidUpdateInputStickKeyboardLEDsWithValue:ledsState];
        }
    }/* else {
        [InputStickLog printRxPacket:rxPacket];
    }*/
    [[NSNotificationCenter defaultCenter] postDidReceiveInputStickPacket:rxPacket];
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
                [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:InputStickAutoConnectFailedKey]; //set to FALSE after successfull connection
                break;
        }
        [[NSNotificationCenter defaultCenter] postDidUpdateInputStickConnectionState:[NSNumber numberWithInt:connectionState]];
    }
}

- (void)setUSBState:(InputStickUSBState)state {
    _usbState = state;
}

- (void)setEncryptionStatus:(BOOL)enabled {
    _encryptionEnabled = enabled;
}

- (void)setFirmwareVersion:(NSUInteger)firmwareVersion {
    _firmwareVersion = firmwareVersion;
    //setup HID buffers depending on HID buffer size available in particular firmware version:
    if (firmwareVersion < 100) {
        [_keyboardBuffer setupWithCapacity:32 maxReportsPerPacket:32];
        [_mouseBuffer setupWithCapacity:32 maxReportsPerPacket:32];
        [_consumerBuffer setupWithCapacity:32 maxReportsPerPacket:32];
    } else {
        [_keyboardBuffer setupWithCapacity:128 maxReportsPerPacket:64];
        [_mouseBuffer setupWithCapacity:64 maxReportsPerPacket:32];
        [_consumerBuffer setupWithCapacity:64 maxReportsPerPacket:32];
    }
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

@end
