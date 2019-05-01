/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDFirmwareManager.h"
#import "InputStickManager.h"
#import "InputStickManager+Protected.h"
#import "InputStickConnectionManager.h"
#import "InputStickEncryptionManager.h"
#import "InputStickPacketParser.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickRxPacket+FirmwareInfo.h"
#import "InputStickRxPacket+HIDUpdate.h"
#import "InputStickHIDBuffersState.h"
#import "InputStickKeyboardLEDsState.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "NSNotificationCenter+InputStickStatusUpdate.h"
#import "InputStickError.h"


//values in seconds:
static NSUInteger const InitTimeoutPeriod = 5; //wait up to 5s to initialize firmware and authenticate
static NSUInteger const USBTimeoutPeriod = 15; //wait up to 15s for USB host to enumerate InputStick
static NSUInteger const MaxVerificationAttempts = 3;


@interface InputStickHIDFirmwareManager () {
    InputStickManager *_inputStickManager;
    InputStickDeviceData *_deviceData;
    
    InputStickFirmwareInitState _initState;
    NSTimer *_initTimeoutTimer;
    NSTimer *_usbTimeoutTimer;
    BOOL _initializing;
    
    NSData *_tmpKey; //stores key until it is confirmed to be correct
    NSUInteger _authenticationAttempts;
    NSUInteger _verificationAttempts;
    BOOL _displayFirmwareUpdateDialog;
}

@end


@implementation InputStickHIDFirmwareManager

- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super init];
    if (self) {
        _inputStickManager = manager;
        _initState = InputStickFirmwareInitStateNone;
    }
    return self;
}

#pragma mark - InputStickFirmwareManagerProtocol

- (void)startInitialization {
    _initializing = TRUE;
    
    _initState = InputStickFirmwareInitStateNone;
    _displayFirmwareUpdateDialog = FALSE;
    [self startInitTimeoutTimer];
    
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdRunFirmware];
    packet.requiresResponse = YES;
    [_inputStickManager sendPacket:packet];
}

- (void)reset {
    _initializing = FALSE;
    [self invalidateInitTimeoutTimer];
    [self invalidateUSBTimeoutTimer];
}

- (void)processPacket:(InputStickRxPacket *)rxPacket {
    if (rxPacket == nil) {
        return;
    }
    if ( !_initializing) {
        return;
    }
    
    Byte* packetBytes = rxPacket.bytes;
    switch (rxPacket.command) {
        case CmdRunFirmware: {
            _tmpKey = nil;
            _authenticationAttempts = 0;
            _verificationAttempts = 0;
            
            [_inputStickManager setEncryptionStatus:NO];
            InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdGetFirmwareInfo];
            packet.requiresResponse = YES;
            [_inputStickManager sendPacket:packet];
            break;
        }
        case CmdGetFirmwareInfo: {
            _deviceData = [_inputStickManager addConectedDeviceToDatabase]; //will create new entry if not already stored in DB
            [_deviceData updateDeviceInfoWithPacket:rxPacket];
            [_inputStickManager setFirmwareVersion:rxPacket.firmwareVersion];
            _initState = InputStickFirmwareInitStateInfo;
            
            if (rxPacket.passwordProtectionEnabled) {
                if ([InputStickEncryptionManager isEnabled]) {
                    if (_deviceData.key == nil) {
                        _deviceData.passwordProtectionStatus = PasswordProtectionEnabledNoKey;
                        _authenticationAttempts++; //this counts as 1st attempt
                        [self showRequestPasswordAlert];
                    } else {
                        [self authenticateWithStoredKey];
                    }
                } else {
                    [self abortWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_APP];
                }
            } else {
                if (_deviceData.key == nil) {
                    _deviceData.passwordProtectionStatus = PasswordProtectionDisabledOK; //no key or will be removed, device is not password protected
                    [self didAuthenticate];
                } else {
                    //remote device is NOT password protected, but encryption key is != nil
                    _deviceData.passwordProtectionStatus = PasswordProtectionDisabledHasKey;
                    [self showKeyRemovedAlert];
                }
            }
            break;
        }
        case CmdAuthenticate:
        case CmdAuthenticateHMAC: {
            _verificationAttempts++;
            switch (packetBytes[1]) {
                case 0x01:
                    //device claims that is uses the same encryption key. Verify challenge response:
                    if ([_inputStickManager.encryptionManager verifyAuthenticationResponsePacket:rxPacket]) {
                        if (_tmpKey != nil) {
                            _deviceData.key = _tmpKey;
                            _tmpKey = nil;
                        }                        
                        [_inputStickManager setEncryptionStatus:YES];
                        _deviceData.passwordProtectionStatus = PasswordProtectionEnabledOK;
                        [self didAuthenticate];
                    } else {
                        if (_verificationAttempts < MaxVerificationAttempts) {
                            if (_tmpKey != nil) {
                                [self authenticateWithTmpKey];
                            } else {
                                [self authenticateWithStoredKey];
                            }
                        } else {
                            _deviceData.passwordProtectionStatus = PasswordProtectionEnabledInvalidKey;
                            [self abortWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_VERIFICATION_FAILED];
                        }
                    }
                    break;
                case 0x20:
                    //invalid key
                    _deviceData.passwordProtectionStatus = PasswordProtectionEnabledInvalidKey;
                    [self showRequestPasswordAlert];
                    break;
                case 0x21:
                    //remote device is NOT password protected; should never get here
                    //_device.key = nil; dialog takes care of this now
                    [self abortWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED];
                    break;
                case 0xFF:
                    //auth cmd was not recognized
                    [self abortWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_DEVICE];
                    break;
                default:
                    //unknown error
                    [self abortWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_GENERAL];
                    break;
            }
            break;
        };
        case CmdHIDStatusNotification: {
            InputStickUSBState usbState = rxPacket.usbState;
            [_inputStickManager setUSBState:usbState];
            
            if (_initState == InputStickFirmwareInitStateConfigured) {
                _initState = InputStickFirmwareInitStateCompletedUSBNotReady;
                if ([_deviceData shouldDisplayFirmwareUpdateMessage]) {
                    _displayFirmwareUpdateDialog = TRUE;
                }
            }
            if (_initState == InputStickFirmwareInitStateCompletedUSBNotReady) {
                if (usbState == USBConfigured) {
                    [_inputStickManager setConnectionState:InputStickReady];
                    _initState = InputStickFirmwareInitStateCompletedUSBReady;
                    [self invalidateUSBTimeoutTimer];
                    if (_displayFirmwareUpdateDialog) {
                        _displayFirmwareUpdateDialog = FALSE;
                        [_inputStickManager presentFirmwareUpdateDialog:_deviceData];
                    }
                } else {
                    [_inputStickManager setConnectionState:InputStickWaitingForUSB];
                }
            }
            if (_initState == InputStickFirmwareInitStateCompletedUSBReady) {
                if (usbState != USBConfigured) {
                    [_inputStickManager setConnectionState:InputStickWaitingForUSB];
                    _initState = InputStickFirmwareInitStateCompletedUSBNotReady;
                }
            }
            break;
        }
        case CmdWdgReset:
            [self abortWithErrorCode:INPUTSTICK_ERROR_HW_WATCHDOG_RESET];
            break;
        case CmdErrorNotification: {
            [self abortWithErrorCode:INPUTSTICK_ERROR_PACKET_TX_GENERAL];
            break;
        }
    }
}

- (void)updateDevicePassword:(NSString *)password {
    if (password == nil) {
        _deviceData.key = nil;
        [self startInitialization]; //re-auth
    } else {
        [self generateTmpKeyFromPassword:password];
        [self authenticateWithTmpKey];
    }
}

#pragma mark - Init Helpers

- (void)abortWithErrorCode:(InputStickErrorCode)errorCode {
    [_inputStickManager.connectionManager disconnectCurrentDeviceWithErrorCode:errorCode];
    //InputStickManager will call reset
}

- (void)didAuthenticate {
    _initState = InputStickFirmwareInitStateAuthenticated;
    [self invalidateInitTimeoutTimer];
    [self startUSBTimeoutTimer];
    
    if (_inputStickManager.firmwareVersion >= 100) {
        //set 400ms update rate
        InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdSetUpdateInterval withParam:4];
        packet.requiresResponse = NO;
        [_inputStickManager sendPacket:packet];
        _initState = InputStickFirmwareInitStateConfigured;  //response was not requested -> mark as configured now
    } else {
        _initState = InputStickFirmwareInitStateConfigured;
    }
}


#pragma mark - Init Timeout

- (void)startInitTimeoutTimer {
    _initTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:InitTimeoutPeriod target:self selector:@selector(initTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)invalidateInitTimeoutTimer {
    if (_initTimeoutTimer) {
        [_initTimeoutTimer invalidate];
        _initTimeoutTimer = nil;
    }
}

- (void)initTimeoutEvent {
    _initTimeoutTimer = nil;
    [self abortWithErrorCode:INPUTSTICK_ERROR_FW_INIT_TIMEDOUT];
}


- (void)startUSBTimeoutTimer {
    _usbTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:USBTimeoutPeriod target:self selector:@selector(usbTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)invalidateUSBTimeoutTimer {
    if (_usbTimeoutTimer) {
        [_usbTimeoutTimer invalidate];
        _usbTimeoutTimer = nil;
    }
}

- (void)usbTimeoutEvent {
    _usbTimeoutTimer = nil;
    [self abortWithErrorCode:INPUTSTICK_ERROR_FW_USB_TIMEDOUT];
}


#pragma mark - Helpers

- (void)generateTmpKeyFromPassword:(NSString *)password {
    _tmpKey = [InputStickEncryptionManager MD5FromString:password];
}

- (void)authenticateWithTmpKey {
    [_inputStickManager.encryptionManager resetStateWithKey:_tmpKey];
    _authenticationAttempts++;
    BOOL hmacEnabled = [_deviceData supportsHMAC];
    [_inputStickManager sendPacket:[_inputStickManager.encryptionManager prepareAuthenticatePacket:hmacEnabled]];
}

- (void)authenticateWithStoredKey {
    [_inputStickManager.encryptionManager resetStateWithKey:_deviceData.key];
    _authenticationAttempts++;
    BOOL hmacEnabled = [_deviceData supportsHMAC];
    [_inputStickManager sendPacket:[_inputStickManager.encryptionManager prepareAuthenticatePacket:hmacEnabled]];
}

- (void)showKeyRemovedAlert {
    [self invalidateInitTimeoutTimer];
    
    [_inputStickManager presentKeyRemovedDialog:_deviceData];
}

- (void)showRequestPasswordAlert {
    [self invalidateInitTimeoutTimer];
    
    if (_authenticationAttempts == 1) { //1st authentication attempt
        if (_deviceData.key != nil) {
            [_inputStickManager presentProvideKeyDialog:_deviceData request:InputStickKeyRequestKeyChanged];
        } else {
            [_inputStickManager presentProvideKeyDialog:_deviceData request:InputStickKeyRequestKeyMissing];
        }
    } else { //2nd, 3rd,... authentication attempt
        [_inputStickManager presentProvideKeyDialog:_deviceData request:InputStickKeyRequestKeyInvalid];
    }
}


@end
