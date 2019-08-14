/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickConst.h"

NSString *const InputStickBluetoothFullUUID = @"0000ffe0-0000-1000-8000-00805f9b34fb"; //does not work properly when code is executed on macOS
NSString *const InputStickBluetoothUUID = @"0000ffe0";
NSString *const InputStickBluetoothDefaultName = @"InputStick";
NSString *const InputStickDatabaseDefaultDeviceName = @"InputStick";
NSString *const InputStickDatabaseClassName = @"InputStick";
NSUInteger const InputStickLatestFirmwareVersion = 110;


NSString *const InputStickStringTable = @"InputStick";
NSString *const InputStickConnectionIcon = @"inputstick_connection_ic.png";
//URLs
NSString *const InputStickWebpageURL = @"http://inputstick.com";
NSString *const InputStickWebpageHelpURL = @"http://inputstick.com/help";
NSString *const InputStickWebpageBuyURL = @"http://inputstick.com/buy";
NSString *const InputStickUtilityAppiTunesURL = @"itms://itunes.apple.com/us/app/inputstickutility/id1356354725?mt=8";
//Stored data
NSString *const InputStickAutoConnectFailedKey = @"InputStickAutoConnectFailed";
NSString *const InputStickStoredIdentifierKey = @"InputStickStoredIdentifier";
NSString *const InputStickDatabaseKey = @"InputStickDeviceDB";
NSString *const InputStickMostRecentDeviceKey = @"InputStickMostRecentDevice";
NSUInteger const InputStickDatabaseMagicNumber = 0xA1B2C3D4;

@implementation InputStickConst


@end
