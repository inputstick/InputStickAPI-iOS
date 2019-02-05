/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "NSNotificationCenter+InputStickPeripheralScan.h"

NSString *const InputStickNotificationPeripheralsListKey = @"PeripheralsList";
NSString *const DidUpdateInputStickPeripheralsNotificationName = @"DidUpdateInputStickPeripheralsNotificationName";
NSString *const DidStartInputStickPeripheralScanNotificationName = @"DidStartInputStickPeripheralScanNotificationName";
NSString *const DidFinishInputStickPeripheralScanNotificationName = @"DidFinishInputStickPeripheralScanNotificationName";
NSString *const DidTimeoutInputStickPeripheralScanNotificationName = @"DidTimeoutInputStickPeripheralScanNotificationName";


@implementation NSNotificationCenter (InputStickPeripheralScan)

#pragma mark - Post notifications

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

- (void)registerForInputStickPeripheralScanNotificationsWithObserver:(id <InputStickPeripheralScanNotificationObserver>)observer {
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

- (void)unregisterFromInputStickPeripheralScanNotificationsWithObserver:(id <InputStickPeripheralScanNotificationObserver>)observer {
    [self removeObserver:observer name:DidUpdateInputStickPeripheralsNotificationName object:nil];
    [self removeObserver:observer name:DidStartInputStickPeripheralScanNotificationName object:nil];
    [self removeObserver:observer name:DidFinishInputStickPeripheralScanNotificationName object:nil];
    [self removeObserver:observer name:DidTimeoutInputStickPeripheralScanNotificationName object:nil];
}

@end
