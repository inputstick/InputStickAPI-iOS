/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header NSNotificationCenter+InputStickPacket.h
 @brief allows to post and register for InputStick incoming packets updates
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickNotificationPacketKey;


@class InputStickRxPacket;

@protocol InputStickPacketNotificationObserver

/*!
 @brief notifies that data packet from InputStick has been received
 @discussion to get packet:
 InputStickRxPacket *packet = notification.userInfo[InputStickNotificationPacketKey];
 */
- (void)didReceiveInputStickPacket:(NSNotification *)notification;

@end


@interface NSNotificationCenter (InputStickPacket)

#pragma mark - Post notifications

- (void)postDidReceiveInputStickPacket:(InputStickRxPacket *)packet;


#pragma mark - Register and unregister observers

- (void)registerForInputStickPacketNotificationsWithObserver:(id <InputStickPacketNotificationObserver>)observer;
- (void)unregisterFromInputStickPacketNotificationsWithObserver:(id <InputStickPacketNotificationObserver>)observer;

@end
