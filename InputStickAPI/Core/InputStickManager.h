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
@class InputStickHIDBuffersManager;

@protocol InputStickManagerDelegate;
@protocol InputStickFirmwareManagerProtocol;

typedef NS_ENUM(NSUInteger, InputStickConnectionState) {
    InputStickDisconnected = 0x00, /*! not connected */
    InputStickConnecting = 0x01, /*! waiting for Bluetooth connection */
    InputStickInitializing = 0x02, /*! initializing InputStick firmware */
    InputStickUSBNotReady = 0x03, /*! USB not configured by host (can NOT send HID reports) */
    InputStickUSBSuspended = 0x04, /*! USB is in suspended (sleep) mode (can NOT send HID reports) */
    InputStickReady = 0x05 /*! ready to send HID reports */
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

typedef NS_ENUM(NSUInteger, InputStickConnectionMode) {
    InputStickConnectionModeNone = 0x00,
    InputStickConnectionModeCustomDevice = 0x01, /*! connecting to InputStick device by providing a custom identifier */
    InputStickConnectionModeLastDevice = 0x02, /*! connecting to the most recently used InputStick device */
    InputStickConnectionModeAutoConnectLastDevice = 0x03, /*! auto-connecting to the most recently used InputStick device */
    InputStickConnectionModeNearestDevice = 0x04, /*! connecting to nearest InputStick device stored in database */
};

typedef NS_ENUM(NSUInteger, InputStickConnectionButtonAction) {
    InputStickConnectionButtonActionNone = 0x00, /*! when the button is pressed: do nothing */
    InputStickConnectionButtonActionConnectLastDevice = 0x01, /*! when the button is pressed: conect to the most recently used InputStick */
    InputStickConnectionButtonActionConnectDiscoverDevices = 0x02, /*! when the button is pressed show InputStickDeviceSelectionTableViewController */
    InputStickConnectionButtonActionCancel = 0x03, /*! when the button is pressed: cancel connection attempt (disconnect) */
    InputStickConnectionButtonActionDisconnect = 0x04, /*! when the button is pressed: disconnect from InputStick */
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

/*! NSUserDefaults used for storing API data, use initWithSuiteName to get NSUserDefaults with custom domain name */
@property(nonatomic, strong, readonly) NSUserDefaults *userDefaults;

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
@property(nonatomic, strong) InputStickHIDBuffersManager *buffersManager;

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

/*! connection mode used during last connection attempt */
@property(nonatomic, readonly) InputStickConnectionMode lastConnectionAttemptMode;
/*! InputStick identifier used during last connection attempt */
@property(nonatomic, readonly) NSString *lastConnectionAttemptInputStickIdentifier;

/*!
 @brief initializes InputStick manager with custom domain identifier that will be used for storing API data (using NSUserDefaults).
 @param suiteName  domain identifier for initializing NSUserDefaults (if nil, standard user defaults will be used)
 @discussion allows to use shared NSUserDefaults to share API data between app(s) and extension(s)
 */
- (instancetype)initWithSuiteName:(NSString *)suiteName;


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
 @brief connects to the most recently used InputStick device, only if auto-connect is enabled in NSUserDefaults
 @return TRUE if auto-connect process started
 @discussion should be called when your application has "auto-connect" option and it was enabled by user.
 If connection attempt fails, auto-connect will be temporarily disabled (until manually connected to any device).
 Will return FALSE if previous attempt failed (is temporarily disabled) or if there are no InputStick devices stored
 */
- (BOOL)autoConnectLastInputStick;

/*!
 @brief connects to the nearest InputStick device
 @discussion will scan for available Bluetooth peripherals for a few seconds and select closest one only from already known (previously connected to) devices
 */
- (void)connectToNearsetStoredInputStick;

/*!
@brief repeats last connection attempt
@discussion the most recently called connection method (connectToInputStickWithIdentifier/connectToLastInputStick/autoConnectLastInputStick/connectToNearsetStoredInputStick) will be called again
*/
- (void)retryConnectionAttempt;

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
