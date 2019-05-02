/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "NSNotificationCenter+InputStickConnection.h"

NSString *const InputStickNotificationConnectionStateKey = @"ConnectionState";
NSString *const InputStickNotificationConnectionErrorCodeKey = @"ErrorCode";
NSString *const DidUpdateInputStickConnectionStateNotificationName = @"DidUpdateInputStickConnectionStateNotificationName";


@implementation NSNotificationCenter (InputStickConnection)

#pragma mark - Post notifications

- (void)postDidUpdateInputStickConnectionState:(NSNumber *)state errorCode:(NSNumber *)errorCode {
    NSDictionary *dict = @{ InputStickNotificationConnectionStateKey : state, InputStickNotificationConnectionErrorCodeKey : errorCode};    
    [self postNotificationName:DidUpdateInputStickConnectionStateNotificationName object:state userInfo:dict];
}


#pragma mark - Register and unregister notifications

- (void)registerForInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer {
    if ([(id)observer respondsToSelector:@selector(didUpdateInputStickConnectionState:)]) {
        [self addObserver:observer selector:@selector(didUpdateInputStickConnectionState:) name:DidUpdateInputStickConnectionStateNotificationName object:nil];
    }
}

- (void)unregisterFromInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer {
    [self removeObserver:observer name:DidUpdateInputStickConnectionStateNotificationName object:nil];
}

@end
