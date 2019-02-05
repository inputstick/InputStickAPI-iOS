/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header NSNotificationCenter+InputStickPeripheralScan.h
 @brief allows to post and register for InputStick peripheral scan status updates
 */


#import <Foundation/Foundation.h>

extern NSString *const InputStickNotificationPeripheralsListKey;

@class InputStickPeripheralInfo;

/*!
 @brief notifies about state of peripheral scan
 */
@protocol InputStickPeripheralScanNotificationObserver

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


@interface NSNotificationCenter (InputStickPeripheralScan)

#pragma mark - Post Notifications

- (void)postDidUpdateInputStickPeripheralsList:(NSMutableArray<InputStickPeripheralInfo *> *)foundPeripherals;

- (void)postDidStartInputStickPeripheralScan;

- (void)postDidFinishInputStickPeripheralScan;

- (void)postDidTimeoutInputStickPeripheralScan;


#pragma mark - Register and Unregister

- (void)registerForInputStickPeripheralScanNotificationsWithObserver:(id <InputStickPeripheralScanNotificationObserver>)observer;

- (void)unregisterFromInputStickPeripheralScanNotificationsWithObserver:(id <InputStickPeripheralScanNotificationObserver>)observer;

@end
