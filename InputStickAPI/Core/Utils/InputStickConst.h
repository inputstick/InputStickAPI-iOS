/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickBluetoothFullUUID;
extern NSString *const InputStickBluetoothUUID;
extern NSString *const InputStickBluetoothDefaultName;
extern NSString *const InputStickDatabaseDefaultDeviceName;
extern NSString *const InputStickDatabaseClassName;
extern NSUInteger const InputStickLatestFirmwareVersion; //application will recommend firmware update if detected version is older (less) than value set here

//UI
extern NSString *const InputStickStringTable;
extern NSString *const InputStickConnectionIcon;
//URLs
extern NSString *const InputStickWebpageURL;
extern NSString *const InputStickWebpageHelpURL;
extern NSString *const InputStickWebpageBuyURL;
extern NSString *const InputStickUtilityAppiTunesURL;
//URL Schemes
extern NSString *const InputStickUtilityLaunchURL;
extern NSString *const InputStickUtilityFirmwareUpdateURL;
//Stored data
extern NSString *const InputStickAutoConnectFailedKey;
extern NSString *const InputStickStoredIdentifierKey;
extern NSString *const InputStickDatabaseKey;
extern NSString *const InputStickMostRecentDeviceKey;
extern NSUInteger const InputStickDatabaseMagicNumber;

@interface InputStickConst : NSObject

@end
