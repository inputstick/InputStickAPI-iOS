//
// Created by Marcin Wieclawski on 13/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISDeviceStatusProvider;
@class ISDeviceBuffersState;

extern NSString *const ISDidUpdateDeviceBuffersNotificationName;
extern NSString *const ISDidUpdateKeyboardLedsNotificationName;

@protocol ResponseParsingNotificationObserver
@optional
- (void)didUpdateDeviceBuffersNotification:(NSNotification *)notification;

- (void)didUpdateKeyboardLedsNotification:(NSNotification *)notification;

@end

@interface NSNotificationCenter (DeviceStatus)

#pragma mark - Post notifications

- (void)postDidUpdateDeviceBuffersStateWithModel:(ISDeviceBuffersState *)deviceBuffersState statusProvider:(ISDeviceStatusProvider *)statusProvider;

- (void)postDidUpdateKeyboardLedsWithValue:(Byte)ledValues statusProvider:(ISDeviceStatusProvider *)statusProvider;

#pragma mark - Register and unregister observers

- (void)registerForDeviceStatusNotificationsWithObserver:(id <ResponseParsingNotificationObserver>)observer;

- (void)unregisterFromDeviceStatusNotificationsWithObserver:(id <ResponseParsingNotificationObserver>)observer;

@end
