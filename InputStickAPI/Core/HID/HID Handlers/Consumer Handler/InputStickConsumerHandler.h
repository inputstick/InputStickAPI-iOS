/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>
#import "InputStickHIDHandler.h"

/*!
 @header InputStickConsumerHandler.h
 @brief allows to send Consumer Control actions (multimedia buttons, power control)
 @discussion The same report buffer is used for Consumer Control, Touch-screen and Gamepad actions
 */

typedef NS_ENUM(Byte, InputStickReportID);
@class InputStickHIDReport;


typedef NS_ENUM(NSUInteger, InputStickConsumerActions) {
    ConsumerActionVolumeUp = 0x00E9,
    ConsumerActionVolumeDown = 0x00EA,
    ConsumerActionVolumeMute = 0x00E2,
    ConsumerActionTrackNext = 0x00B5,
    ConsumerActionTrackPrevious = 0x00B6,
    ConsumerActionStop = 0x00B7,
    ConsumerActionPlayPause = 0x00CD,
    ConsumerActionLaunchBrowser = 0x0196,
    ConsumerActionLaunchEmail = 0x018A,
    ConsumerActionLaunchCalc = 0x0192,
    
    ConsumerActionHome = 0x0223,
    ConsumerActionBack = 0x0224,
    ConsumerActionForward = 0x0225,
    ConsumerActionRefresh = 0x0227,
    ConsumerActionSearch = 0x0221
};

typedef NS_ENUM(Byte, InputStickSystemActions) {
    SystemActionPowerDown = 0x01,
    SystemActionSleep = 0x02,
    SystemActionWakeup = 0x03
};

@interface InputStickConsumerHandler : NSObject <InputStickHIDHandler>

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;


#pragma mark - Custom Report

/*!
 @brief creates Consumer Control HID report
 @param reportId identifies report type
 @param lsbUsage least significant byte of usage code
 @param msbUsage most significant byte of usage code
 @return Consumer Control InputStickHIDReport
 @discussion reportId must match type of usage code (System, Consumer Control etc.), see InputStickManager
 */
- (InputStickHIDReport *)customReportWithId:(InputStickReportID)reportId LSBUsage:(Byte)lsbUsage MSBUsage:(Byte)msbUsage;

/*!
 @brief queues Consumer Control HID report
 @param reportId identifies report type
 @param lsbUsage least significant byte of usage code
 @param msbUsage most significant byte of usage code
 @param sendASAP if TRUE HID Consumer Control buffer will be flushed
 @discussion reportId must match type of usage code (System, Consumer Control etc.), see InputStickManager
 */
- (void)sendCustomReportWithId:(InputStickReportID)reportId LSBUsage:(Byte)lsbUsage MSBUsage:(Byte)msbUsage sendASAP:(BOOL)sendASAP;


#pragma mark - Consumer actions

/*!
 @brief sends requested actions to InputStick
 @param usage USB HID Consumer Control Page usage code
 */
- (void)consumerActionWithUsage:(InputStickConsumerActions)usage;

/*!
 @brief sends requested actions to InputStick
 @param usage USB HID System Page usage code
 */
- (void)systemActionWithUsage:(InputStickSystemActions)usage;

@end
