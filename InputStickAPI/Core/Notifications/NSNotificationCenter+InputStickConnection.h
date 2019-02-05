/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header NSNotificationCenter+InputStickConnection.h
 @brief allows to post and register for InputStick connection status updates
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickNotificationConnectionStateKey;

/*!
 @brief notifies about changes of InputStick connection state
 */
@protocol InputStickConnectionNotificationObserver

/*!
 @brief notifies that InputStick connection state has changed
 @discussion to get current connection state:
 1) NSNumber *tmp = (NSNumber *)notification.userInfo[InputStickNotificationConnectionStateKey];
 InputStickConnectionState state = tmp.unsignedIntegerValue;
 2) inputStickManager.connectionState
 */
- (void)didUpdateInputStickConnectionState:(NSNotification *)notification;

@end


@interface NSNotificationCenter (InputStickConnection)

#pragma mark - Post Notifications

- (void)postDidUpdateInputStickConnectionState:(NSNumber *)connectionState;


#pragma mark - Register and Unregister

- (void)registerForInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer;

- (void)unregisterFromInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer;

@end
