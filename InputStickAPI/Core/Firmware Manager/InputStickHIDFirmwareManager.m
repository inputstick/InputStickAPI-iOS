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
#import "InputStickHIDBuffersState.h"
#import "InputStickKeyboardLEDsState.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "NSNotificationCenter+InputStickStatusUpdate.h"
#import "InputStickError.h"


//values in seconds:
static NSUInteger const InitTimeout = 3; //time limit for firmware initialization and authentication
static NSTimeInterval const USBShortTimeout = 15; //use for the very first attempt, error message will appear sooner if USB host is off/not responding/not present (charger/powerbank)
static NSTimeInterval const USBLongTimeout = 30; //use if USB host was already successfully detected, but then its state changed (sleep mode). Disconnect to save power
static NSUInteger const MaxVerificationAttempts = 5;
static NSUInteger const MaxInitAttempts = 2;


@interface InputStickHIDFirmwareManager () {
    InputStickManager *_inputStickManager;
    InputStickDeviceData *_deviceData;
    
    InputStickFirmwareInitState _initState;
    InputStickUSBState _usbState;
    
    NSData *_tmpKey; //stores key until it is confirmed to be correct
    NSString *_tmpPlainText;
    NSUInteger _authenticationAttempts;
    NSUInteger _verificationAttempts;
    NSUInteger _initAttempts;
    
    NSTimer *_initTimeoutTimer;
    NSTimer *_usbTimeoutTimer;
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
    _initState = InputStickFirmwareInitStateStarted;
    _usbState = USBDisconnected;
    _initAttempts = 1;
    [self startInitTimeoutTimer];
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdRunFirmware];
    packet.requiresResponse = YES;
    [_inputStickManager sendPacket:packet];
}

- (void)reset {
    _initState = InputStickFirmwareInitStateNone;
    [self invalidateTimers];
}

- (void)processPacket:(InputStickRxPacket *)rxPacket {
    if (rxPacket == nil || _initState == InputStickFirmwareInitStateNone) {
        return;
    }
    
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
            _initState = InputStickFirmwareInitStateAuthenticating;
            
            if (rxPacket.passwordProtectionEnabled) {
                if ([InputStickEncryptionManager isSupported]) {
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
            switch (rxPacket.respCode) {
                case 0x01:
                    //device claims that is uses the same encryption key. Verify challenge response:
                    if ([_inputStickManager.encryptionManager verifyAuthenticationResponsePacket:rxPacket]) {
                        if (_tmpKey != nil) {
                            _deviceData.key = _tmpKey;
                            _deviceData.plainText = _tmpPlainText;
                            _tmpKey = nil;
                            _tmpPlainText = nil;
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
            InputStickUSBState prevUSBState = _usbState;
            Byte *dataBytes = (Byte *)rxPacket.data.bytes;
            _usbState = dataBytes[0];
            [_inputStickManager setUSBState:_usbState];
            
            if (_initState == InputStickFirmwareInitStateAuthenticated) {
                //this will be executed only once
                _initState = InputStickFirmwareInitStateCompleted;
                switch (_usbState) {
                    case USBConfigured:
                        [_inputStickManager setConnectionState:InputStickReady];
                        [self invalidateTimers];
                        if ([_deviceData shouldDisplayFirmwareUpdateMessage]) {
                            [_inputStickManager presentFirmwareUpdateDialog:_deviceData];
                        }
                        break;
                    case USBSuspended:
                        [_inputStickManager setConnectionState:InputStickUSBSuspended];
                        [self invalidateTimers];
                        [_inputStickManager presentUSBResumeDialog:_deviceData];
                        break;
                    default:
                        [_inputStickManager setConnectionState:InputStickUSBNotReady];
                        break;
                }
            } else if (_initState == InputStickFirmwareInitStateCompleted) {
                //handle changes between USB host ready/not ready/suspended
                if (_usbState != prevUSBState) {
                    switch (_usbState) {
                        case USBConfigured:
                            [_inputStickManager setConnectionState:InputStickReady];
                            [self invalidateTimers];
                            break;
                        case USBSuspended:
                            [_inputStickManager setConnectionState:InputStickUSBSuspended];
                            [self startUSBTimeoutTimer:USBLongTimeout];
                            break;
                        default:
                            [_inputStickManager setConnectionState:InputStickUSBNotReady];
                            [self startUSBTimeoutTimer:USBLongTimeout];
                            break;
                    }
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

- (void)updateDevicePassword:(NSString *)password savePlainText:(BOOL)savePlainText {
    if (password == nil) {
        _deviceData.key = nil;
        [self startInitialization]; //re-auth
    } else {
        [self generateTmpKeyFromPassword:password savePlainText:savePlainText];
        [self authenticateWithTmpKey];
    }
}

#pragma mark - Init Helpers

- (void)abortWithErrorCode:(InputStickErrorCode)errorCode {
    [_inputStickManager disconnectWithErrorCode:errorCode];
    //InputStickManager will call reset
}

- (void)didAuthenticate {
    [self invalidateTimers];
    [self startUSBTimeoutTimer:USBShortTimeout];
    if ([_deviceData supportsCustomUpdateNotificationInterval]) {
        //set 400ms update rate
        InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdSetUpdateInterval withParam:4];
        packet.requiresResponse = NO;
        [_inputStickManager sendPacket:packet];
        //response was not requested -> this step completes configuration
    }
    _initState = InputStickFirmwareInitStateAuthenticated;
}


#pragma mark - Init Timeout

- (void)startInitTimeoutTimer {
    _initTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:InitTimeout target:self selector:@selector(initTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)initTimeoutEvent {
    _initTimeoutTimer = nil;
    
    if (_initAttempts < MaxInitAttempts) {
        _initAttempts++;
        [self startInitTimeoutTimer];
        InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdRunFirmware];
        packet.requiresResponse = YES;
        [_inputStickManager sendPacket:packet];
    } else {
        [self abortWithErrorCode:INPUTSTICK_ERROR_FW_INIT_TIMEDOUT];
    }
}


- (void)startUSBTimeoutTimer:(NSTimeInterval)duration {
    _usbTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(usbTimeoutEvent) userInfo:nil repeats:NO];
}

- (void)usbTimeoutEvent {
    _usbTimeoutTimer = nil;
    if (_usbState == USBSuspended) {
        [self abortWithErrorCode:INPUTSTICK_ERROR_FW_USB_SUSPENDED];
    } else {
        [self abortWithErrorCode:INPUTSTICK_ERROR_FW_USB_NOT_READY];
    }
}

- (void)invalidateTimers {
    if (_initTimeoutTimer) {
        [_initTimeoutTimer invalidate];
        _initTimeoutTimer = nil;
    }
    if (_usbTimeoutTimer) {
        [_usbTimeoutTimer invalidate];
        _usbTimeoutTimer = nil;
    }
}


#pragma mark - Helpers

- (void)generateTmpKeyFromPassword:(NSString *)password savePlainText:(BOOL)savePlainText {
    _tmpKey = [InputStickEncryptionManager MD5FromString:password];
    if (savePlainText) {
        _tmpPlainText = password;
    } else {
        _tmpPlainText = nil;
    }
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
    [self invalidateTimers];
    [_inputStickManager presentEncryptionKeyDialog:_deviceData request:InputStickKeyRequestKeyRemoved];
}

- (void)showRequestPasswordAlert {
    [self invalidateTimers];
    
    if (_authenticationAttempts == 1) { //1st authentication attempt
        if (_deviceData.key != nil) {
            [_inputStickManager presentEncryptionKeyDialog:_deviceData request:InputStickKeyRequestKeyChanged];
        } else {
            [_inputStickManager presentEncryptionKeyDialog:_deviceData request:InputStickKeyRequestKeyMissing];
        }
    } else { //2nd, 3rd,... authentication attempt
        [_inputStickManager presentEncryptionKeyDialog:_deviceData request:InputStickKeyRequestKeyInvalid];
    }
}


@end
