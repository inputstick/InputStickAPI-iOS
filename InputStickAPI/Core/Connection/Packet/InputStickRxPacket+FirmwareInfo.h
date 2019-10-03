/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickRxPacket+FirmwareInfo.h
 @brief represents data received as response for packet with CmdGetFirmwareInfo command
 */

#import <Foundation/Foundation.h>
#import "InputStickRxPacket.h"


@interface InputStickRxPacket (FirmwareInfo)

@property (nonatomic, readonly) NSUInteger firmwareVersion;
@property (nonatomic, readonly) BOOL passwordProtectionEnabled;
@property (nonatomic, readonly) BOOL unlocked;
@property (nonatomic, readonly) BOOL authenticated;
@property (nonatomic, readonly) BOOL isValid;

@end
