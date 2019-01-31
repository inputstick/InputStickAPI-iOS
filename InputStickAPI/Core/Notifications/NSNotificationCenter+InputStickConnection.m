/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "NSNotificationCenter+InputStickConnection.h"

NSString *const InputStickNotificationPeripheralsListKey = @"PeripheralsList";
NSString *const InputStickNotificationConnectionStateKey = @"ConnectionState";

NSString *const DidUpdateInputStickPeripheralsNotificationName = @"DidUpdateInputStickPeripheralsNotificationName";
NSString *const DidUpdateInputStickConnectionStateNotificationName = @"DidUpdateInputStickConnectionStateNotificationName";

NSString *const DidStartInputStickPeripheralScanNotificationName = @"DidStartInputStickPeripheralScanNotificationName";
NSString *const DidFinishInputStickPeripheralScanNotificationName = @"DidFinishInputStickPeripheralScanNotificationName";
NSString *const DidTimeoutInputStickPeripheralScanNotificationName = @"DidTimeoutInputStickPeripheralScanNotificationName";


@implementation NSNotificationCenter (InputStickConnection)

#pragma mark - Post notifications

- (void)postDidUpdateInputStickConnectionState:(NSNumber *)state {
    [self postNotificationName:DidUpdateInputStickConnectionStateNotificationName object:state userInfo:state ? @{InputStickNotificationConnectionStateKey : state} : nil];
}

- (void)postDidUpdateInputStickPeripheralsList:(NSMutableArray<InputStickPeripheralInfo *> *)foundPeripherals {
    NSMutableArray<InputStickPeripheralInfo *> *cpy = [foundPeripherals copy];
    [self postNotificationName:DidUpdateInputStickPeripheralsNotificationName object:cpy userInfo:@{InputStickNotificationPeripheralsListKey : cpy}];
}

- (void)postDidStartInputStickPeripheralScan {
    [self postNotificationName:DidStartInputStickPeripheralScanNotificationName object:nil];
}

- (void)postDidFinishInputStickPeripheralScan {
    [self postNotificationName:DidFinishInputStickPeripheralScanNotificationName object:nil];
}

- (void)postDidTimeoutInputStickPeripheralScan {
    [self postNotificationName:DidTimeoutInputStickPeripheralScanNotificationName object:nil];
}


#pragma mark - Register and unregister notifications

- (void)registerForInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer {
    if ([(id)observer respondsToSelector:@selector(didUpdateInputStickConnectionState:)]) {
        [self addObserver:observer selector:@selector(didUpdateInputStickConnectionState:) name:DidUpdateInputStickConnectionStateNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didUpdateInputStickPeripheralsList:)]) {
        [self addObserver:observer selector:@selector(didUpdateInputStickPeripheralsList:) name:DidUpdateInputStickPeripheralsNotificationName object:nil];
    }
    
    if ([(id)observer respondsToSelector:@selector(didStartInputStickPeripheralScan)]) {
        [self addObserver:observer selector:@selector(didStartInputStickPeripheralScan) name:DidStartInputStickPeripheralScanNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didFinishInputStickPeripheralScan)]) {
        [self addObserver:observer selector:@selector(didFinishInputStickPeripheralScan) name:DidFinishInputStickPeripheralScanNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didTimeoutInputStickPeripheralScan)]) {
        [self addObserver:observer selector:@selector(didTimeoutInputStickPeripheralScan) name:DidTimeoutInputStickPeripheralScanNotificationName object:nil];
    }
}

- (void)unregisterFromInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer {
    [self removeObserver:observer name:DidUpdateInputStickConnectionStateNotificationName object:nil];
    [self removeObserver:observer name:DidUpdateInputStickPeripheralsNotificationName object:nil];
    
    [self removeObserver:observer name:DidStartInputStickPeripheralScanNotificationName object:nil];
    [self removeObserver:observer name:DidFinishInputStickPeripheralScanNotificationName object:nil];
    [self removeObserver:observer name:DidTimeoutInputStickPeripheralScanNotificationName object:nil];
}

@end
