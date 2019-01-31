/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "NSNotificationCenter+InputStickPacket.h"
#import "InputStickRxPacket.h"

NSString *const DidReceiveInputStickPacketName = @"DidReceiveInputStickPacketName";
NSString *const InputStickNotificationPacketKey = @"PacketKey";


@implementation NSNotificationCenter (InputStickPacket)

#pragma mark - Post Notifications

- (void)postDidReceiveInputStickPacket:(InputStickRxPacket *)packet {    
    [self postNotificationName:DidReceiveInputStickPacketName object:packet userInfo:@{InputStickNotificationPacketKey : packet}];    
}


#pragma mark - Register and unregister observers

- (void)registerForInputStickPacketNotificationsWithObserver:(id <InputStickPacketNotificationObserver>)observer {
    if ([(id)observer respondsToSelector:@selector(didReceiveInputStickPacket:)]) {
        [self addObserver:observer selector:@selector(didReceiveInputStickPacket:) name:DidReceiveInputStickPacketName object:nil];
    }
}

- (void)unregisterFromInputStickPacketNotificationsWithObserver:(id <InputStickPacketNotificationObserver>)observer {
    [self removeObserver:observer name:DidReceiveInputStickPacketName object:nil];
}

@end
