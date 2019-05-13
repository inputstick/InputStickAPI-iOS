/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardLEDsState.h"
#import "InputStickRxPacket.h"


@implementation InputStickKeyboardLEDsState

- (instancetype)initWithInputStickRxPacket:(InputStickRxPacket *)rxPacket {
    self = [super init];
    if (self) {
        Byte *dataBytes = (Byte *)rxPacket.data.bytes;
        [self updateLedsWithByte:dataBytes[1]];
    }
    return self;
}

- (void)updateLedsWithByte:(Byte)ledsByte {
    _rawValue = ledsByte;
    if ((ledsByte & 0x01) != 0) {
        _numLockOn = TRUE;
    } else {
        _numLockOn = FALSE;
    }

    if ((ledsByte & 0x02) != 0) {
        _capsLockOn = TRUE;
    } else {
        _capsLockOn = FALSE;
    }

    if ((ledsByte & 0x04) != 0) {
        _scrollLockOn = TRUE;
    } else {
        _scrollLockOn = FALSE;
    }
}

@end
