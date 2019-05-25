/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickManager.h
 @brief allows to manage InputStick connection, send data to connected InputStick, access HID interface handlers
 @discussion
 ***********************************************************************************
 ************************************ IMPORTANT ************************************
 ***********************************************************************************
 ** Make sure to include NSBluetoothPeripheralUsageDescription in Info.plist file **
 ***********************************************************************************
 ***********************************************************************************
 */

#import <Foundation/Foundation.h>

@class InputStickConnectionManager;
@class InputStickEncryptionManager;
@class InputStickPacketParser;
@class InputStickDeviceDB;
@class InputStickDeviceData;
@class InputStickTxPacket;
@class InputStickRxPacket;
@class InputStickKeyboardHandler;
@class InputStickMouseHandler;
@class InputStickConsumerHandler;
@class InputStickTouchScreenHandler;
@class InputStickGamepadHandler;
@class InputStickHIDTransaction;
@class InputStickHIDReport;

@protocol InputStickManagerDelegate;
@protocol InputStickFirmwareManagerProtocol;

typedef NS_ENUM(NSUInteger, InputStickConnectionState) {
    InputStickDisconnected = 0x00, /*! not connected */
    InputStickConnecting = 0x01, /*! waiting for Bluetooth connection */
    InputStickInitializing = 0x02, /*! initializing InputStick firmware */
    InputStickWaitingForUSB = 0x03, /*! firmware initialized, can NOT send HID reports (USB not configured by host) */
    InputStickReady = 0x04 /*! ready send HID reports */
};

typedef NS_ENUM(NSUInteger, InputStickUSBState) {
    USBDisconnected = 0x00, /*! Waiting for USB host to configure InputStick, or there is only USB power*/
    USBAttached = 0x01, /*! Waiting for USB host to configure InputStick */
    USBPowered = 0x02, /*! Waiting for USB host to configure InputStick */
    USBSuspended = 0x03, /*! USB host is most likely in sleep mode */
    USBAddressed = 0x04, /*! Waiting for USB host to configure InputStick */
    USBConfigured = 0x05 /*! InputStick can send HID reports */
};

typedef NS_ENUM(NSUInteger, InputStickHIDInterface) {
    InputStickHIDInterfaceKeyboard = 0x01,
    InputStickHIDInterfaceMouse = 0x02,
    InputStickHIDInterfaceConsumer = 0x04,
};

typedef NS_ENUM(Byte, InputStickReportID) {
    InputStickConsumerReportID = 1, /*! Consumer Control Report ID for USB Consumer Control Interfrace */
    InputStickSystemReportID = 2, /*! System Report ID for USB Consumer Control Interfrace */
    InputStickGamepadReportID = 3, /*! Gamepad Report ID for USB Consumer Control Interfrace */
    InputStickTouchScreenReportID = 4, /*! TouchScreen Report ID for USB Consumer Control Interfrace */
};

typedef NS_ENUM(NSUInteger, InputStickPasswordProtectionStatus) {
    PasswordProtectionDisabledOK = 0x00, /*! InputStick is not password protected, there is no encryption key saved */
    PasswordProtectionEnabledOK = 0x01, /*! InputStick is password protected, there is encryption key saved */
    PasswordProtectionDisabledHasKey = 0x02, /*! InputStick is password protected, but there is encryption key saved (must be removed) */
    PasswordProtectionEnabledNoKey = 0x03, /*! InputStick is password protected, but there is no encryption key saved (must be provided) */
    PasswordProtectionEnabledInvalidKey = 0x04, /*! InputStick is password protected, but saved encryption key is invalid */
};

typedef NS_ENUM(NSUInteger, InputStickKeyRequest) {
    InputStickKeyRequestKeyRemoved = 0x00, /*! key was removed from remote device, user must be notified about this */
    InputStickKeyRequestKeyMissing = 0x01, /*! key must be provided by user, there is no saved key */
    InputStickKeyRequestKeyChanged = 0x02, /*! key must be provided by user, saved key is incorrect */
    InputStickKeyRequestKeyInvalid = 0x03, /*! key that was provided by user is incorrect */
};


@interface InputStickManager : NSObject

/*! delegate for handling actions that require user attention (connection error messages, password requests etc.) */
@property(nonatomic, weak) id <InputStickManagerDelegate> delegate;
/*! if not nil, overrides delegate (used for InputStick Menu, see iOS/ViewControllers) */
@property(nonatomic, weak) id <InputStickManagerDelegate> inputStickMenuDelegate;

@property(nonatomic, strong, readonly) InputStickConnectionManager *connectionManager;
@property(nonatomic, strong, readonly) InputStickEncryptionManager *encryptionManager;
@property(nonatomic, strong, readonly) InputStickDeviceDB *deviceDB;
@property(nonatomic, strong) id<InputStickFirmwareManagerProtocol> firmwareManager;

/*! if TRUE Bluetooth is turned on */
@property(nonatomic, readonly) BOOL bluetoothOn;
/*! if TRUE this iOS/macOS device supports Bluetooth */
@property(nonatomic, readonly) BOOL bluetoothSupported;
/*! if TRUE InputStick is currently disconnected (same as connectionState == InputStickDisconnected) */
@property(nonatomic, readonly) BOOL inputStickDicsonnected;
/*! if TRUE InputStick is currently ready to use (same as connectionState == InputStickReady) */
@property(nonatomic, readonly) BOOL inputStickReady;

/*! InputStickDeviceData of currently connected device (nil if not connected) */
@property(nonatomic, weak, readonly) InputStickDeviceData *connectedInputStickDeviceData;
/*! Bluetooth UUID of currently connected device (nil if not connected) */
@property(nonatomic, readonly) NSString *connectedInputStickIdentifier;
/*! Bluetooth name of currently connected device (nil if not connected) */
@property(nonatomic, readonly) NSString *connectedInputStickBluetoothName;

//HID Buffers
/*! if TRUE all local and remote (InputStick) buffers are empty */
@property(nonatomic, readonly) BOOL allBuffersEmpty;

/*! if TRUE local and remote (InputStick) keyboard buffers are empty */
@property(nonatomic, readonly) BOOL keyboardBufferEmpty;

/*! if TRUE local keyboard buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL keyboardLocalBufferEmpty;

/*! if TRUE local and remote (InputStick) mouse buffers are empty */
@property(nonatomic, readonly) BOOL mouseBufferEmpty;

/*! if TRUE local mouse buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL mouseLocalBufferEmpty;

/*! if TRUE local and remote (InputStick) Consumer Control (used for Consumer, Touch-screen, Gamepad reports) buffers are empty */
@property(nonatomic, readonly) BOOL consumerBufferEmpty;

/*! if TRUE local Consumer Control (used for Consumer, Touch-screen, Gamepad reports) buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL consumerLocalBufferEmpty;

/*! HID Keyboard interface handler */
@property(nonatomic, strong) InputStickKeyboardHandler *keyboardHandler;
/*! HID Mouse interface handler */
@property(nonatomic, strong) InputStickMouseHandler *mouseHandler;
/*! HID Consumer Control (multimedia) interface handler */
@property(nonatomic, strong) InputStickConsumerHandler *consumerHandler;
/*! HID Touch-screen interface handler */
@property(nonatomic, strong) InputStickTouchScreenHandler *touchScreenHandler;
/*! HID Gamepad interface handler */
@property(nonatomic, strong) InputStickGamepadHandler *gamepadHandler;

/*! current InputStick connection state */
@property(nonatomic, readonly) InputStickConnectionState connectionState;
/*! current USB state */
@property(nonatomic, readonly) InputStickUSBState usbState;
/*! if TRUE communication with InputStick is encrypted */
@property(nonatomic, readonly) BOOL encryptionEnabled;

/*! firmware version of connected device, 100 corresponds 1.00 */
@property(nonatomic, readonly) NSUInteger firmwareVersion;
/*! last error (reason for getting disconnected/connection attempt failure) */
@property(nonatomic, strong, readonly) NSError *lastError;
/*! time when last error occurred */
@property(nonatomic, readonly) NSUInteger lastErrorTime;

#pragma mark - InputStick Connection

/*!
 @brief connects to InputStick device with specified identifier
 @param identifier  Bluetooth UUID of InputStick to connect to
 */
- (void)connectToInputStickWithIdentifier:(NSString *)identifier;

/*!
 @brief connects to the most recently used InputStick device
 */
- (void)connectToLastInputStick;

/*!
 @brief connects to the nearest InputStick device
 @discussion will scan for available Bluetooth peripherals for a few seconds and select closest one only from already known (previously connected to) devices
 */
- (void)connectToNearsetStoredInputStick;

/*!
 @brief connects to the most recently used InputStick device, only if auto-connect is enabled in NSUserDefaults
 @return TRUE if auto-connect process started
 @discussion should be called when your application has "auto-connect" option and it was enabled by user.
 If connection attempt fails, auto-connect will be temporarily disabled (until manually connected to any device).
 Will return FALSE if previous attempt failed (is temporarily disabled) or if there are no InputStick devices stored
 */
- (BOOL)autoConnectLastInputStick;

/*!
 @brief disconnects from InputStick device
 */
- (void)disconnectFromInputStick;

/*!
 @brief checks if there is at least one saved InputStick device
 @return TRUE if there is at least one stored device identifier
 @discussion device identifiers are automatically stored when connected to InputStick
 */
- (BOOL)hasStoredDeviceIdentifier;

/*!
 @brief attempts to authenticate using provided password. If authentication is successful, stored password will be updated (and optionally also stored as plain text)
 @param password new password (plain text) or nil to remove password
 @param savePlainText if true, password will be also stored as plain text
 @discussion should be used when user is notified about missing/changed password and provides new password
 */
- (void)updateDevicePassword:(NSString *)password savePlainText:(BOOL)savePlainText;


#pragma mark - BT scan

/*!
 @brief starts Bluetooth peripheral scan
 @param enableTimeout if TRUE peripheral scan will be stopped after 15 seconds
 @discussion scan is always stopped after connected to InputStick, if necessary must be manually started again once disconnected
 */
- (void)startBluetoothPeripheralScanWithTimeout:(BOOL)enableTimeout;

/*!
 @brief stops Bluetooth peripheral scan
 */
- (void)stopBluetoothPeripheralScan;


#pragma mark - HID Buffers

/*!
 @brief clears local HID report buffers for all available interfaces and requests InputStick to clear all of its report buffers
 @discussion use this method to stop all keyboard, mouse etc. actions as soon as possible. InputStick will release pressed keys or mouse buttons if necessary
 */
- (void)clearHIDBuffers;


#pragma mark - HID Keyboard Buffer

/*!
 @brief clears local HID keyboard report buffer and requests InputStick to clear its keyboard report buffer
 @discussion use this method to stop all keyboard actions as soon as possible. InputStick will release pressed keys if necessary
 */
- (void)clearKeyboardBuffer;

/*!
 @brief removes all reports from local HID keyboard report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearKeyboardLocalBuffer;

/*!
 @brief adds HID keyboard report to queue
 @param report HID report to add
 @param flush if TRUE HID keyboard buffer will be flushed (same as calling flushKeyboardBuffer method)
 */
- (void)addKeyboardHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID keyboard transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID keyboard buffer will be flushed (same as calling flushKeyboardBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addKeyboardHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID keyboard report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushKeyboardBuffer;


#pragma mark - HID Mouse Buffer

/*!
 @brief clears local HID mouse report buffer and requests InputStick to clear its mouse report buffer
 @discussion use this method to stop all mouse actions as soon as possible. InputStick will release pressed mouse buttons if necessary
 */
- (void)clearMouseBuffer;

/*!
 @brief removes all reports from local HID mouse report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearMouseLocalBuffer;

/*!
 @brief adds HID mouse report to queue
 @param report HID report to add
 @param flush if TRUE HID mouse buffer will be flushed (same as calling flushMouseBuffer method)
 */
- (void)addMouseHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID mouse transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID mouse buffer will be flushed (same as calling flushMouseBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addMouseHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID mouse report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushMouseBuffer;


#pragma mark - HID Consumer Buffer
//Note: HID Consumer Control Interface is used for consumer control (multimedia, power) actions, touch-screen and gamepad. All actions share the same report buffer both locally and on InputStick

/*!
 @brief clears local HID consumer control report buffer and requests InputStick to clear its consumer control report buffer
 @discussion use this method to stop all consumer control, touch-screen and gamepad actions as soon as possible. InputStick will reset touch-screen and gamepad state if necessary
 */
- (void)clearConsumerBuffer;

/*!
 @brief removes all reports from local HID consumer control report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearConsumerLocalBuffer;

/*!
 @brief adds HID consumer control, touch-screen or gamepad report to queue
 @param report HID report to add
 @param flush if TRUE HID consumer control buffer will be flushed (same as calling flushConsumerBuffer method)
 */
- (void)addConsumerHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID consumer control, touch-screen or gamepad transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID consumer control buffer will be flushed (same as calling flushConsumerBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addConsumerHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID consumer control report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushConsumerBuffer;


#pragma mark - Send/Receive Data

/*!
 @brief sends packet to InputStick
 @param txPacket packet to send
 */
- (void)sendPacket:(InputStickTxPacket *)txPacket;


#pragma mark - Screenshot helpers

/*!
 @brief pretends to be connected to InputStick
 @discussion use when taking screenshots using simulator, works only when executing on simulator
 */
- (void)setDummyConnectedState;

/*!
 @brief adds dummy InputStick to devices database
 @discussion use when taking screenshots using simulator, works only when executing on simulator
 */
- (void)addDummyDevice;


@end
