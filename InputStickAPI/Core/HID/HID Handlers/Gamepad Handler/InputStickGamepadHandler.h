/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickGamepadHandler.h
 @brief allows to send Gamepad actions.
 @discussion Gamepad actions are sent to USB host via Consumer Control Interface.
 The same report buffer is used for Consumer Control, Touch-screen and Gamepad actions.
 Due to nature of gamepad, instead of queuing Gamepad reports, they are written directly to USB Consumer Control endpoint.
 If the endpoint is busy (unlikely if only Gamepad reports are being sent), Gamepad report is lost.
 It is assumed that Gamepad reports are being constantly send and loosing a report won't cause any significant problems.
 */

#import <Foundation/Foundation.h>
#import "InputStickHIDHandler.h"

@class InputStickHIDReport;

typedef NS_ENUM(NSUInteger, InputStickGamepadButton) {
    GamepadButtonNone = 0x0000,
    GamepadButton1 = 0x0001,
    GamepadButton2 = 0x0002,
    GamepadButton3 = 0x0004,
    GamepadButton4 = 0x0008,
    GamepadButton5 = 0x0010,
    GamepadButton6 = 0x0020,
    GamepadButton7 = 0x0040,
    GamepadButton8 = 0x0080,
    GamepadButton9 = 0x0100,
    GamepadButton10 = 0x0200,
    GamepadButton11 = 0x0400,
    GamepadButton12 = 0x0800,
    GamepadButton13 = 0x1000,
    GamepadButton14 = 0x2000,
    GamepadButton15 = 0x4000,
    GamepadButton16 = 0x8000
};


@interface InputStickGamepadHandler : NSObject <InputStickHIDHandler>

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;


#pragma mark - Custom Report

/*!
 @brief creates Gamepad HID report
 @param buttons pressed gamepad buttons 
 @param x x axis value (-127 to 127)
 @param y y axis value (-127 to 127)
 @param z z axis value (-127 to 127)
 @param rx rx axis value (-127 to 127)
 @return Gamepad InputStickHIDReport
 @discussion Gamepad HID reports must be sent via Consumer Control interface or sent directly to USB Consumer Control endpoint
 */
- (InputStickHIDReport *)customReportWithButtons:(NSUInteger)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx;

/*!
 @brief sends Gamepad HID report
 @param buttons pressed gamepad buttons
 @param x x axis value (-127 to 127)
 @param y y axis value (-127 to 127)
 @param z z axis value (-127 to 127)
 @param rx rx axis value (-127 to 127)
 @discussion For lowest possible latency, Gamepad HID reports are not queued but sent directly to USB endpoint. If endpoint is busy, report is lost
 */
- (void)sendCustomReportWithButtons:(NSUInteger)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx;

@end
