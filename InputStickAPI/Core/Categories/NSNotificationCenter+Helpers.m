/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "NSNotificationCenter+Helpers.h"


@implementation NSNotificationCenter (Helpers)

- (void)addObserver:(id)observer ifRespondsToSelector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    if ([observer respondsToSelector:aSelector]) {
        [self addObserver:observer
                 selector:aSelector
                     name:aName
                   object:anObject];
    }
}

@end
