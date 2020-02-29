/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickMouseHandler.h
 @brief allows to send Mouse actions
 @discussion Mouse interface uses relative screen coordinates.
 If you need to use absolute screen coordinates, use Touch-screen instead. See InputStickTouchScreenHandler
 */


#import <Foundation/Foundation.h>
#import "InputStickHIDHandler.h"

@class InputStickManager;
@class InputStickHIDReport;

typedef NS_ENUM(Byte, InputStickMouseButtons) {
    MouseButtonNone = 0x00,
    MouseButtonLeft = 0x01,
    MouseButtonRight = 0x02,
    MouseButtonMiddle = 0x04,
    MouseButton4 = 0x08,
    MouseButton5 = 0x10,
    MouseButton6 = 0x20,
    MouseButton7 = 0x40,
    MouseButton8 = 0x80,
};

@interface InputStickMouseHandler : NSObject<InputStickHIDHandler>

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;


#pragma mark - Custom Report

/*!
 @brief creates Mouse HID report
 @param buttons pressed mouse buttons
 @param x change of x axis (-127 to 127)
 @param y change of x axis (-127 to 127)
 @param scroll scroll wheel rotation (-127 to 127)
 @return Mouse InputStickHIDReport
 @discussion See InputStickMouseButtons
 */
- (InputStickHIDReport *)customReportWithButtons:(Byte)buttons x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)scroll;

/*!
 @brief queues Mouse HID report
 @param buttons pressed mouse buttons
 @param x change of x axis (-127 to 127)
 @param y change of x axis (-127 to 127)
 @param scroll scroll wheel rotation (-127 to 127)
 @param flush if TRUE HID Mouse buffer will be flushed
 @discussion See InputStickMouseButtons
 */
- (void)sendCustomReportWithButtons:(Byte)buttons x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)scroll flush:(BOOL)flush;


#pragma mark - Mouse actions

/*!
 @brief changes mouse cursor position by x,y
 @param x change of x axis (-127 to 127)
 @param y change of x axis (-127 to 127)
 */
- (void)moveCursorByX:(SignedByte)x y:(SignedByte)y;

/*!
 @brief rotates scroll wheel
 @param scroll scroll wheel rotation (-127 to 127)
 */
- (void)scroll:(SignedByte)scroll;

/*!
 @brief clicks specified mouse button for specified number of times
 @param buttons mouse button(s) to click
 @param numberOfPresses number of clicks
 @discussion See InputStickMouseButtons
 */
- (void)clickWithButtons:(Byte)buttons numberOfPress:(NSUInteger)numberOfPresses;

/*!
 @brief clicks specified mouse button for specified number of times
 @param buttons mouse button(s) to click
 @param numberOfPresses number of clicks
 @param multiplier reduction of clicking speed
 @discussion Multiplier reduces clicking speed by multiplying HID reports, same as typing speed in InputStickKeyboardHandler.
 See InputStickMouseButtons
 */
- (void)clickWithButtons:(Byte)buttons numberOfPress:(NSUInteger)numberOfPresses multiplier:(NSUInteger)multiplier;

@end
