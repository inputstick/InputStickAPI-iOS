//
// Created by Marcin Wieclawski on 12/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Helpers)

- (void)addObserver:(id)observer ifRespondsToSelector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

@end
