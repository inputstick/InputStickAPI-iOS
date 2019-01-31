/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickTouchScreenHandler.h
 @brief allows to send Touch-screen actions
 @discussion Touch-screen actions are sent to USB host via Consumer Control Interface.
 The same report buffer is used for Consumer Control, Touch-screen and Gamepad actions.
 Touch-screen interface uses absolute screen coordinates.
 Range for x,y coordinates is 0 to 10000, where 0 is 0% of screen width/height and 10000 is 100%. Example: 5000,5000 represents center of the screen.
 Touch-screen interface emulates stylus (pen/finger), it can have following states:
 - out of proximity of the screen surface (OS should hide any additional UI)
 - in proximity of the screen surface (OS may show additional UI)
 - touch the screen surface (same as pressing left mouse button)
 You may get different behavior, depending on OS.
 Some USB hosts do not support Touch-screen interface. Use Mouse interface in such case
 */

#import <Foundation/Foundation.h>
#import "InputStickHIDHandler.h"

@class InputStickManager;
@class InputStickHIDReport;

@interface InputStickTouchScreenHandler : NSObject<InputStickHIDHandler>

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;


#pragma mark - Custom Report

/*!
 @brief creates Touch-Screen HID report
 @param tipSwitch TRUE if stylus (finger) presses (clicks) screen surface
 @param inRange TRUE if stylus (finger) is in proximity of screen surface
 @param x x coordinate (0 to 10000)
 @param y y coordinate (0 to 10000)
 @return Touch-Screen InputStickHIDReport
 @discussion Touch-Screen reports must be sent via Consumer Control interface
 */
- (InputStickHIDReport *)customReportWithTipSwitch:(BOOL)tipSwitch inRange:(BOOL)inRange x:(NSUInteger)x y:(NSUInteger)y;

/*!
 @brief queues Touch-Screen HID report
 @param tipSwitch TRUE if stylus (finger) presses (clicks) screen surface
 @param inRange TRUE if stylus (finger) is in proximity of screen surface
 @param x x coordinate (0 to 10000)
 @param y y coordinate (0 to 10000)
 @param sendASAP if TRUE HID Consumer Control buffer will be flushed
 @discussion Touch-Screen reports are sent via Consumer Control interface
 */
- (void)sendCustomReportWithTipSwitch:(BOOL)tipSwitch inRange:(BOOL)inRange x:(NSUInteger)x y:(NSUInteger)y sendASAP:(BOOL)sendASAP;


#pragma mark - TouchScreen actions

/*!
 @brief moves stylus (finger) to specified coordinates
 @param x x coordinate (0 to 10000)
 @param y y coordinate (0 to 10000)
 @param button TRUE if stylus (finger) presses (clicks) screen surface
 @discussion in most cases result will be the same as clicking left mouse button. For middle and right button clicks use InputStickMouseHandler
 */
- (void)moveTouchPointerToX:(NSUInteger)x y:(NSUInteger)y withButtonPressed:(BOOL)button;

/*!
 @brief presses (clicks) screen surface at specified coordinates for specified number of times
 @param x x coordinate (0 to 10000)
 @param y y coordinate (0 to 10000)
 @param n number of clicks
 @discussion in most cases result will be the same as clicking left mouse button. For middle and right button clicks use InputStickMouseHandler
 */
- (void)clickAtX:(NSUInteger)x y:(NSUInteger)y numberOfTimes:(NSUInteger)n;

/*!
 @brief moves stylus (finger) to specified coordinates and moves stylus (finger) out of screen surface proximity
 @param x x coordinate (0 to 10000)
 @param y y coordinate (0 to 10000)
 @discussion this should result in hiding touch-screen related UI on USB host
 */
- (void)goOutOfRangeAtX:(NSUInteger)x y:(NSUInteger)y;

@end
