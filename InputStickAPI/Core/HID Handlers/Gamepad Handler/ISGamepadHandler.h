//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISHIDHandler.h"

typedef NS_ENUM(NSInteger, GamepadButtons) {
    GAMEPAD_BUTTON_NONE = 0x0000,
    GAMEPAD_BUTTON_01 = 0x0001,
    GAMEPAD_BUTTON_02 = 0x0002,
    GAMEPAD_BUTTON_03 = 0x0004,
    GAMEPAD_BUTTON_04 = 0x0008,
    GAMEPAD_BUTTON_05 = 0x0010,
    GAMEPAD_BUTTON_06 = 0x0020,
    GAMEPAD_BUTTON_07 = 0x0040,
    GAMEPAD_BUTTON_08 = 0x0080,
    GAMEPAD_BUTTON_09 = 0x0100,
    GAMEPAD_BUTTON_10 = 0x0200,
    GAMEPAD_BUTTON_11 = 0x0400,
    GAMEPAD_BUTTON_12 = 0x0800,
    GAMEPAD_BUTTON_13 = 0x1000,
    GAMEPAD_BUTTON_14 = 0x2000,
    GAMEPAD_BUTTON_15 = 0x4000,
    GAMEPAD_BUTTON_16 = 0x8000
};

@interface ISGamepadHandler : NSObject <ISHIDHandler>

- (instancetype)initWithManager:(ISManager *)manager;

- (void)sendCustomReportWithButtons:(GamepadButtons)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx;

@end
