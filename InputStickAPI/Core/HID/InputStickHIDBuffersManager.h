/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */
#import <Foundation/Foundation.h>

@class InputStickManager;
@class InputStickHIDBuffersState;
@class InputStickHIDReport;
@class InputStickHIDTransaction;

@interface InputStickHIDBuffersManager : NSObject


@property(nonatomic, weak, readonly) InputStickManager *manager;

/*! if TRUE all local and remote (InputStick) buffers are empty */
@property(nonatomic, readonly) BOOL allBuffersEmpty;

/*! if TRUE local and remote (InputStick) keyboard buffers are empty */
@property(nonatomic, readonly) BOOL keyboardBufferEmpty;

/*! if TRUE local keyboard buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL keyboardLocalBufferEmpty;

/*! if TRUE local and remote (InputStick) mouse buffers are empty */
@property(nonatomic, readonly) BOOL mouseBufferEmpty;

/*! if TRUE local mouse buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL mouseLocalBufferEmpty;

/*! if TRUE local and remote (InputStick) Consumer Control (used for Consumer, Touch-screen, Gamepad reports) buffers are empty */
@property(nonatomic, readonly) BOOL consumerBufferEmpty;

/*! if TRUE local Consumer Control (used for Consumer, Touch-screen, Gamepad reports) buffer is empty, remote (InputStick) buffer may still have reports */
@property(nonatomic, readonly) BOOL consumerLocalBufferEmpty;


- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager;


#pragma mark - HID Buffers

/*!
 @brief clears local HID report buffers for all available interfaces and requests InputStick to clear all of its report buffers
 @discussion use this method to stop all keyboard, mouse etc. actions as soon as possible. InputStick will release pressed keys or mouse buttons if necessary
 */
- (void)clearHIDBuffers;


#pragma mark - HID Keyboard Buffer

/*!
 @brief clears local HID keyboard report buffer and requests InputStick to clear its keyboard report buffer
 @discussion use this method to stop all keyboard actions as soon as possible. InputStick will release pressed keys if necessary
 */
- (void)clearKeyboardBuffer;

/*!
 @brief removes all reports from local HID keyboard report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearKeyboardLocalBuffer;

/*!
 @brief adds HID keyboard report to queue
 @param report HID report to add
 @param flush if TRUE HID keyboard buffer will be flushed (same as calling flushKeyboardBuffer method)
 */
- (void)addKeyboardHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID keyboard transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID keyboard buffer will be flushed (same as calling flushKeyboardBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addKeyboardHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID keyboard report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushKeyboardBuffer;


#pragma mark - HID Mouse Buffer

/*!
 @brief clears local HID mouse report buffer and requests InputStick to clear its mouse report buffer
 @discussion use this method to stop all mouse actions as soon as possible. InputStick will release pressed mouse buttons if necessary
 */
- (void)clearMouseBuffer;

/*!
 @brief removes all reports from local HID mouse report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearMouseLocalBuffer;

/*!
 @brief adds HID mouse report to queue
 @param report HID report to add
 @param flush if TRUE HID mouse buffer will be flushed (same as calling flushMouseBuffer method)
 */
- (void)addMouseHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID mouse transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID mouse buffer will be flushed (same as calling flushMouseBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addMouseHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID mouse report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushMouseBuffer;


#pragma mark - HID Consumer Buffer
//Note: HID Consumer Control Interface is used for consumer control (multimedia, power) actions, touch-screen and gamepad. All actions share the same report buffer both locally and on InputStick

/*!
 @brief clears local HID consumer control report buffer and requests InputStick to clear its consumer control report buffer
 @discussion use this method to stop all consumer control, touch-screen and gamepad actions as soon as possible. InputStick will reset touch-screen and gamepad state if necessary
 */
- (void)clearConsumerBuffer;

/*!
 @brief removes all reports from local HID consumer control report buffer
 @discussion reports already sent to InputStick will not be affected
 */
- (void)clearConsumerLocalBuffer;

/*!
 @brief adds HID consumer control, touch-screen or gamepad report to queue
 @param report HID report to add
 @param flush if TRUE HID consumer control buffer will be flushed (same as calling flushConsumerBuffer method)
 */
- (void)addConsumerHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

/*!
 @brief adds HID consumer control, touch-screen or gamepad transaction to queue
 @param transaction HID transaction to add
 @param flush if TRUE HID consumer control buffer will be flushed (same as calling flushConsumerBuffer method)
 @discussion HID transaction can have multiple reports that will be sent in a single packet. This prevents from delays between reports (caused by Bluetooth latency) or sending only some of them (if Bluetooth connection is lost). Transaction will be split if number of reports exceeds max reports per packet.
 */
- (void)addConsumerHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

/*!
 @brief sends reports from local HID consumer control report buffer to InputStick
 @discussion number of reports sent will depend on free space available in InputSticks HID keyboard report buffer
 */
- (void)flushConsumerBuffer;

@end
