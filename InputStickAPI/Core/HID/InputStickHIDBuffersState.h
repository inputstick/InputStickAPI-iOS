/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickHIDBuffersState.h
 @brief represents current state of InputStick HID report buffers (Remote HID Buffers)
 */

#import <Foundation/Foundation.h>

@class InputStickRxPacket;

@interface InputStickHIDBuffersState : NSObject

/*! number of HID keyboard interface reports sent to USB host since previous update */
@property(nonatomic) NSUInteger keyboardReportsSentToHost;

/*! number of HID mouse interface reports sent to USB host since previous update */
@property(nonatomic) NSUInteger mouseReportsSentToHost;

/*! number of HID consumer control interface reports sent to USB host since previous update (includes gamepad and touch-screen reports) */
@property(nonatomic) NSUInteger consumerReportsSentToHost;

/*! if TRUE, InputStick HID keyboard interface report buffer is empty */
@property(nonatomic) BOOL keyboardBufferEmpty;

/*! if TRUE, InputStick HID mouse interface report buffer is empty */
@property(nonatomic) BOOL mouseBufferEmpty;

/*! if TRUE, InputStick HID consumer control interface report buffer is empty */
@property(nonatomic) BOOL consumerBufferEmpty;

- (instancetype)initWithInputStickRxPacket:(InputStickRxPacket *)rxPacket;

@end
