/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "ISKeyboardLedsState.h"


@implementation ISKeyboardLedsState

- (instancetype)initWithLedByte:(Byte)ledsByte {
    self = [super init];
    if (self) {
        [self updateLedsWithByte:ledsByte];
    }
    return self;
}

- (void)updateLedsWithByte:(Byte)ledsByte {
    if ((ledsByte & 0x01) != 0) {
        _numLockOn = true;
    } else {
        _numLockOn = false;
    }

    if ((ledsByte & 0x02) != 0) {
        _capsLockOn = true;
    } else {
        _capsLockOn = false;
    }

    if ((ledsByte & 0x04) != 0) {
        _scrollLockOn = true;
    } else {
        _scrollLockOn = false;
    }
}

@end
