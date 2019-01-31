/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header NSNotificationCenter+InputStickStatusUpdate.h
 @brief allows to post and register for InputStick status updates (HID buffer state changes, keyboard LEDs state changes)
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickNotificationHIDBuffersStateKey;
extern NSString *const InputStickNotificationKeyboardLEDsKey;

@class InputStickHIDBuffersState;
@class InputStickKeyboardLEDsState;


@protocol InputStickStatusUpdateNotificationObserver

@optional

/*!
 @brief notifies that at least one of HID report buffers has become empty
 @discussion status updates are received from InputStick every 500ms (firmware v1.00 and later) or 100ms (before v1.00).
 To check state of HID report buffers:
 inputStickManager.keyboardBufferEmpty etc.
 */
- (void)didUpdateInputStickHIDBuffersStateNotification:(NSNotification *)notification;

/*!
 @brief notifies that state of keyboard LEDs has changed
 @discussion to get current state of keyboard LEDs:
 1) InputStickKeyboardLEDsState *keyboardLEDsState = notification.userInfo[InputStickNotificationKeyboardLEDsKey];
 2) inputStickManager.keyboardHandler.numLockOn etc.
 */
- (void)didUpdateInputStickKeyboardLEDsNotification:(NSNotification *)notification;

/*!
 @brief notifies that both local and remote (InputStick) keyboard report buffers are now empty
 */
- (void)didEmptyInputStickKeyboardBufferNotification;

/*!
 @brief notifies that both local and remote (InputStick) mouse report buffers are now empty
 */
- (void)didEmptyInputStickMouseBufferNotification;

/*!
 @brief notifies that both local and remote (InputStick) consumer control (includes touch-screen and gamepad reports) report buffers are now empty
 */
- (void)didEmptyInputStickConsumerBufferNotification;

/*!
 @brief notifies that local keyboard report buffer is now empty
 @discussion there can still be reports queued in remote (InputStick) keyboard report buffer
 */
- (void)didEmptyInputStickKeyboardLocalBufferNotification;

/*!
 @brief notifies that local mouse report buffer is now empty
 @discussion there can still be reports queued in remote (InputStick) mouse report buffer
 */
- (void)didEmptyInputStickMouseLocalBufferNotification;

/*!
 @brief notifies that local consumer control (includes touch-screen and gamepad reports) report buffer is now empty
 @discussion there can still be reports queued in remote (InputStick) consumer control report buffer
 */
- (void)didEmptyInputStickConsumerLocalBufferNotification;

@end


@interface NSNotificationCenter (InputStickStatusUpdate)

#pragma mark - Post notifications

- (void)postDidUpdateInputStickHIDBuffersStateWithModel:(InputStickHIDBuffersState *)hidBuffersState; 

- (void)postDidUpdateInputStickKeyboardLEDsWithValue:(InputStickKeyboardLEDsState *)keyboardLEDsState;

- (void)postDidEmptyInputStickKeyboardBuffer;
- (void)postDidEmptyInputStickMouseBuffer;
- (void)postDidEmptyInputStickConsumerBuffer;

- (void)postDidEmptyInputStickKeyboardLocalBuffer;
- (void)postDidEmptyInputStickMouseLocalBuffer;
- (void)postDidEmptyInputStickConsumerLocalBuffer;


#pragma mark - Register and unregister observers

- (void)registerForInputStickStatusUpdateNotificationsWithObserver:(id <InputStickStatusUpdateNotificationObserver>)observer;

- (void)unregisterFromInputStickStatusUpdateNotificationsWithObserver:(id <InputStickStatusUpdateNotificationObserver>)observer;

@end
