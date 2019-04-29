/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickDeviceData.h
 @brief saved data for previously connected InputStick device. Allows to store Bluetooth UUID, device info, encryption key,  etc.
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, InputStickPasswordProtectionStatus);
@class InputStickDeviceDB;
@class InputStickRxPacket;

@interface InputStickDeviceData : NSObject

@property(nonatomic, weak) InputStickDeviceDB *db;

/*! display name */
@property(nonatomic, strong) NSString *name;    //can be used to assign custom names. By default InputStick (n) will be used.
/*! Bluetooth UUID */
@property(nonatomic, strong) NSString *identifier;
/*! 128B AES encryption key (MD5(plainText)) */
@property(nonatomic, strong) NSData *key;
/*! plain text device password (not stored by default) */
@property(nonatomic, strong) NSString *plainText;
/*! most recent password protection status */
@property(nonatomic) InputStickPasswordProtectionStatus passwordProtectionStatus;
/*! most recently reported firmware version */
@property(nonatomic, readonly) NSUInteger firmwareVersion;
/*! time ater which next firmware update reminder can be displayed, can be always displayed when set to 0 and never when set to 1 */
@property(nonatomic, readonly) NSUInteger nextAllowedFirmwareUpdateReminder;

- (instancetype)initWithDeviceDB:(InputStickDeviceDB *)db withIdentifier:(NSString *)identifier withName:(NSString *)name;

/*!
 @brief updates device info with data received as a response to CmdGetFirmwareInfo request command
 @param rxPacket response packet for CmdGetFirmwareInfo request command
 */
- (void)updateDeviceInfoWithPacket:(InputStickRxPacket *)rxPacket;

/*!
 @brief checks if there are any password protection-related problems
 @return TRUE if there is password-protection related problem
 @discussion if TRUE is returned it is necessary to check what causes the problem (missing key, invalid key etc.)
 */
- (BOOL)hasPasswordProtectionIssue;


#pragma mark Firmware Update

/*!
 @brief postopne next firmware update messages by specified number of seconds from now
 @param seconds number of seconds to postope next message
 @discussion firmware update messages will not be requested when connected to this device as long as time (when connection is established) is less than now+seconds
 */
- (void)postponeFirmwareUpdateReminderBy:(NSUInteger)seconds;

/*!
 @brief disable firmware update messages for this device
 */
- (void)disableFirmwareUpdateReminder;

/*!
 @brief checks if firmware update message should be displayed
 @return TRUE if firmware update message should be displayed
 */
- (BOOL)shouldDisplayFirmwareUpdateMessage;

/*!
 @brief checks if this device has latest available firmware version
 @return TRUE if this device has latest available firmware version
 */
- (BOOL)hasLatestFirmware;

/*!
 @brief firmware version as NSString, example: 1.01
 @return firmware version as NSString
 */
- (NSString *)firmwareVersionString;


#pragma mark Device Capabilities

/*!
 @brief checks if this device supports USB and BT name configuration changes
 @return TRUE if this device supports USB and BT name configuration changes
 */
- (BOOL)supportsConfiguration;

/*!
 @brief checks if this device supports setting custom interval for status update notifications
 @return TRUE if this device supports setting custom interval for status update notifications
 */
- (BOOL)supportsCustomUpdateNotificationInterval;

/*!
 @brief checks if this device requires HMAC
 @return TRUE if this device requires HMAC
 */
- (BOOL)supportsHMAC;

/*!
 @brief checks if this device supports encryption key generation
 @return TRUE if this device supports encryption key generation
 */
- (BOOL)supportsKeygen;


@end
