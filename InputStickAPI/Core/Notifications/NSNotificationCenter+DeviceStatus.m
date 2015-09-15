/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "NSNotificationCenter+DeviceStatus.h"
#import "ISDeviceStatusProvider.h"
#import "NSNotificationCenter+Helpers.h"
#import "ISDeviceBuffersState.h"
#import "ISKeyboardLedsState.h"


NSString *const ISDidUpdateDeviceBuffersNotificationName = @"ISDidUpdateDeviceBuffersNotification";
NSString *const ISDidUpdateKeyboardLedsNotificationName = @"ISDidUpdateKeyboardLedsNotification";

@implementation NSNotificationCenter (DeviceStatus)

#pragma mark - Post Notifications

- (void)postDidUpdateDeviceBuffersStateWithModel:(ISDeviceBuffersState *)deviceBuffersState statusProvider:(ISDeviceStatusProvider *)statusProvider {
    if (deviceBuffersState.sendKeyboardReports) {
        NSLog(@"Send to keyboard: %d", deviceBuffersState.sendKeyboardReports);
    }
    if (deviceBuffersState.sendMouseReports) {
        NSLog(@"Send to mouse: %d", deviceBuffersState.sendMouseReports);
    }
    if (deviceBuffersState.sendConsumerReports) {
        NSLog(@"Send to consumer: %d", deviceBuffersState.sendConsumerReports);
    }
    [self postNotificationName:ISDidUpdateDeviceBuffersNotificationName
                        object:statusProvider
                      userInfo:@{@"responseUpdateModel" : deviceBuffersState}];
}

- (void)postDidUpdateKeyboardLedsWithValue:(Byte)ledValues statusProvider:(ISDeviceStatusProvider *)statusProvider {
    ISKeyboardLedsState *keyboardLedsState = [[ISKeyboardLedsState alloc] initWithLedByte:ledValues];
    [self postNotificationName:ISDidUpdateKeyboardLedsNotificationName
                        object:statusProvider
                      userInfo:@{@"keyboardLedsState" : keyboardLedsState}];
}

#pragma mark - Register and unregister observers

- (void)registerForDeviceStatusNotificationsWithObserver:(id <ResponseParsingNotificationObserver>)observer {
    [self addObserver:observer
 ifRespondsToSelector:@selector(didUpdateDeviceBuffersNotification:)
                 name:ISDidUpdateDeviceBuffersNotificationName
               object:nil];

    [self addObserver:observer
 ifRespondsToSelector:@selector(didUpdateKeyboardLedsNotification:)
                 name:ISDidUpdateKeyboardLedsNotificationName
               object:nil];
}

- (void)unregisterFromDeviceStatusNotificationsWithObserver:(id <ResponseParsingNotificationObserver>)observer {
    [self removeObserver:observer
                    name:ISDidUpdateDeviceBuffersNotificationName
                  object:nil];

    [self removeObserver:observer
                    name:ISDidUpdateKeyboardLedsNotificationName
                  object:nil];
}

@end
