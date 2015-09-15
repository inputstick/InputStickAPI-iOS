//
// Created by Marcin Wieclawski on 15/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISKeyboardLedsState : NSObject
@property(nonatomic, readonly) BOOL numLockOn;
@property(nonatomic, readonly) BOOL capsLockOn;
@property(nonatomic, readonly) BOOL scrollLockOn;

- (instancetype)initWithLedByte:(Byte)ledsByte;

@end
