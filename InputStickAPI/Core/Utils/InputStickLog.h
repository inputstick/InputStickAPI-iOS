/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

//remove if you don't want 0x prefix to be printed
#define INPUTSTICK_LOG_PRINT_HEX_PREFIX

@class InputStickDeviceData;
@class InputStickPreferences;
@class InputStickRxPacket;
@class InputStickTxPacket;

@interface InputStickLog : NSObject

+ (NSString *)hexStringFromData:(NSData *)data;
+ (NSData *)dataFromHexString:(NSString *)hex;

+ (void)printHexNSData:(NSData *)data;
+ (void)printHexNSData:(NSData *)data withTitle:(NSString *)title;
+ (void)printHexByte:(Byte)byte;
+ (void)printHexByte:(Byte)byte  withTitle:(NSString *)title;

+ (void)printDeviceData:(InputStickDeviceData *)deviceData;
+ (void)printPreferences:(InputStickPreferences *)preferences;
+ (void)printRxPacket:(InputStickRxPacket *)packet;
+ (void)printTxPacket:(InputStickTxPacket *)packet;

@end

