/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "NSNotificationCenter+InputStickStatusUpdate.h"
#import "InputStickHIDBuffersState.h"
#import "InputStickKeyboardLEDsState.h"

NSString *const InputStickNotificationHIDBuffersStateKey = @"BuffersState";
NSString *const InputStickNotificationKeyboardLEDsKey = @"KeyboardLEDs";

NSString *const DidUpdateInputStickHIDBuffersNotificationName = @"DidUpdateInputStickHIDBuffersNotificationName";
NSString *const didUpdateInputStickKeyboardLEDsNotificationName = @"didUpdateInputStickKeyboardLEDsNotificationName";

NSString *const DidEmptyInputStickKeyboardBufferNotificationName = @"DidEmptyInputStickKeyboardBufferNotificationName";
NSString *const DidEmptyInputStickMouseBufferNotificationName = @"DidEmptyInputStickMouseBufferNotificationName";
NSString *const DidEmptyInputStickConsumerBufferNotificationName = @"DidEmptyInputStickConsumerBufferNotificationName";

NSString *const DidEmptyInputStickKeyboardLocalBufferNotificationName = @"DidEmptyInputStickKeyboardLocalBufferNotificationName";
NSString *const DidEmptyInputStickMouseLocalBufferNotificationName = @"DidEmptyInputStickMouseLocalBufferNotificationName";
NSString *const DidEmptyInputStickConsumerLocalBufferNotificationName = @"DidEmptyInputStickConsumerLocalBufferNotificationName";


@implementation NSNotificationCenter (InputStickStatusUpdate)

#pragma mark - Post Notifications

- (void)postDidUpdateInputStickHIDBuffersStateWithModel:(InputStickHIDBuffersState *)hidBuffersState {
    [self postNotificationName:DidUpdateInputStickHIDBuffersNotificationName object:nil userInfo:@{InputStickNotificationHIDBuffersStateKey : hidBuffersState}];
}

- (void)postDidUpdateInputStickKeyboardLEDsWithValue:(InputStickKeyboardLEDsState *)keyboardLEDsState {
    [self postNotificationName:didUpdateInputStickKeyboardLEDsNotificationName object:keyboardLEDsState userInfo:@{InputStickNotificationKeyboardLEDsKey : keyboardLEDsState}];
}

- (void)postDidEmptyInputStickKeyboardBuffer {
    [self postNotificationName:DidEmptyInputStickKeyboardBufferNotificationName object:nil];
}
- (void)postDidEmptyInputStickMouseBuffer {
    [self postNotificationName:DidEmptyInputStickMouseBufferNotificationName object:nil];
}
- (void)postDidEmptyInputStickConsumerBuffer {
    [self postNotificationName:DidEmptyInputStickConsumerBufferNotificationName object:nil];
}

- (void)postDidEmptyInputStickKeyboardLocalBuffer {
    [self postNotificationName:DidEmptyInputStickKeyboardLocalBufferNotificationName object:nil];
}
- (void)postDidEmptyInputStickMouseLocalBuffer {
    [self postNotificationName:DidEmptyInputStickMouseLocalBufferNotificationName object:nil];
}
- (void)postDidEmptyInputStickConsumerLocalBuffer {
    [self postNotificationName:DidEmptyInputStickConsumerLocalBufferNotificationName object:nil];
}


#pragma mark - Register and unregister observers

- (void)registerForInputStickStatusUpdateNotificationsWithObserver:(id <InputStickStatusUpdateNotificationObserver>)observer {
    if ([(id)observer respondsToSelector:@selector(didUpdateInputStickHIDBuffersStateNotification:)]) {
        [self addObserver:observer selector:@selector(didUpdateInputStickHIDBuffersStateNotification:) name:DidUpdateInputStickHIDBuffersNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didUpdateInputStickKeyboardLEDsNotification:)]) {
        [self addObserver:observer selector:@selector(didUpdateInputStickKeyboardLEDsNotification:) name:didUpdateInputStickKeyboardLEDsNotificationName object:nil];
    }
    
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickKeyboardBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickKeyboardBufferNotification) name:DidEmptyInputStickKeyboardBufferNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickMouseBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickMouseBufferNotification) name:DidEmptyInputStickMouseBufferNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickConsumerBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickConsumerBufferNotification) name:DidEmptyInputStickConsumerBufferNotificationName object:nil];
    }
    
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickKeyboardLocalBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickKeyboardLocalBufferNotification) name:DidEmptyInputStickKeyboardLocalBufferNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickMouseLocalBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickMouseLocalBufferNotification) name:DidEmptyInputStickMouseLocalBufferNotificationName object:nil];
    }
    if ([(id)observer respondsToSelector:@selector(didEmptyInputStickConsumerLocalBufferNotification)]) {
        [self addObserver:observer selector:@selector(didEmptyInputStickConsumerLocalBufferNotification) name:DidEmptyInputStickConsumerLocalBufferNotificationName object:nil];
    }
}

- (void)unregisterFromInputStickStatusUpdateNotificationsWithObserver:(id <InputStickStatusUpdateNotificationObserver>)observer {
    [self removeObserver:observer name:DidUpdateInputStickHIDBuffersNotificationName object:nil];
    [self removeObserver:observer name:didUpdateInputStickKeyboardLEDsNotificationName object:nil];
    
    [self removeObserver:observer name:DidEmptyInputStickKeyboardBufferNotificationName object:nil];
    [self removeObserver:observer name:DidEmptyInputStickMouseBufferNotificationName object:nil];
    [self removeObserver:observer name:DidEmptyInputStickConsumerBufferNotificationName object:nil];
    
    [self removeObserver:observer name:DidEmptyInputStickKeyboardLocalBufferNotificationName object:nil];
    [self removeObserver:observer name:DidEmptyInputStickMouseLocalBufferNotificationName object:nil];
    [self removeObserver:observer name:DidEmptyInputStickConsumerLocalBufferNotificationName object:nil];
}

@end
