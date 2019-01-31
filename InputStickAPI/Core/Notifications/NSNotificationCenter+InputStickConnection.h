/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header NSNotificationCenter+InputStickConnection.h
 @brief allows to post and register for InputStick connection status updates
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickNotificationPeripheralsListKey;
extern NSString *const InputStickNotificationConnectionStateKey;

@class InputStickPeripheralInfo;

/*!
 @brief notifies about changes of InputStick connection state and optionally, peripheral scan
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

@optional

/*!
 @brief notifies that list of nearby InputStick peripherals has been updated
 @discussion to get list of detected nearby peripherals (see InputStickPeripheralInfo):
 1) NSArray *list = (NSArray *)notification.userInfo[InputStickNotificationPeripheralsListKey];
 2) inputStickManager.connectionManager.foundPeripherals
 */
- (void)didUpdateInputStickPeripheralsList:(NSNotification *)notification;

/*!
 @brief notifies that InputStick peripheral scan has been started
 */
- (void)didStartInputStickPeripheralScan;

/*!
 @brief notifies that InputStick peripheral scan has finished
 */
- (void)didFinishInputStickPeripheralScan;

/*!
 @brief notifies that InputStick peripheral scan has timed out
 */
- (void)didTimeoutInputStickPeripheralScan;

@end


@interface NSNotificationCenter (InputStickConnection)

#pragma mark - Post Notifications

- (void)postDidUpdateInputStickPeripheralsList:(NSMutableArray<InputStickPeripheralInfo *> *)foundPeripherals;

- (void)postDidUpdateInputStickConnectionState:(NSNumber *)connectionState;

- (void)postDidStartInputStickPeripheralScan;
- (void)postDidFinishInputStickPeripheralScan;
- (void)postDidTimeoutInputStickPeripheralScan;


#pragma mark - Register and Unregister

- (void)registerForInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer;

- (void)unregisterFromInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer;

@end
