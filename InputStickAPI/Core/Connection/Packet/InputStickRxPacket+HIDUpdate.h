/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickRxPacket+FirmwareInfo.h
 @brief represents data received as packet with CmdHIDStatusNotification command
 */

#import <Foundation/Foundation.h>
#import "InputStickRxPacket.h"


typedef NS_ENUM(NSUInteger, InputStickUSBState);


@interface InputStickRxPacket (HIDUpdate)

@property (nonatomic, readonly) InputStickUSBState usbState;

@end
