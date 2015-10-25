/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISMouseHandler.h"
#import "ISManager.h"
#import "ISReport.h"
#import "ISBluetoothBuffer.h"

const Byte MOUSE_BUTTON_NONE = 0x00;
const Byte MOUSE_BUTTON_LEFT = 0x01;
const Byte MOUSE_BUTTON_RIGHT = 0x02;
const Byte MOUSE_BUTTON_MIDDLE = 0x04;


@implementation ISMouseHandler
@synthesize inputStickManager = _inputStickManager;

#pragma mark - Object lifecycle

- (instancetype)initWithManager:(ISManager *)manager {
    self = [super init];
    if (self) {
        _inputStickManager = manager;
    }
    return self;
}

#pragma mark - Custom Report

- (void)sendCustomReportWithButtons:(Byte)buttons withX:(Byte)x withY:(Byte)y withScroll:(Byte)scroll sendASAP:(BOOL)sendASAP {
    ISReport *reportModel = [ISReport mouseReportWithBytes:(Byte[4]) {buttons, x, y, scroll}];
    [self.inputStickManager.blueToothBuffer addMouseReportToQueue:reportModel sendASAP:sendASAP];
}

#pragma mark - Mouse actions

- (void)sendMoveWithX:(Byte)x positionY:(Byte)y {
    [self sendCustomReportWithButtons:0x00 withX:x withY:y withScroll:0x00
                             sendASAP:YES];
}

- (void)sendScroll:(Byte)scrollValue {
    [self sendCustomReportWithButtons:0x00 withX:0x00 withY:0x00 withScroll:scrollValue
                             sendASAP:YES];
}

- (void)sendPressedButtons:(Byte)buttons withNumberOfPress:(NSInteger)numberOfPresses withMultiplier:(NSInteger)multiplier {
    if (multiplier < 1) {
        multiplier = 1;
    }

    for (int clickCount = 0; clickCount < numberOfPresses; ++clickCount) {
        //Button release
        for (int i = 0; i < multiplier; ++i) {
            [self sendCustomReportWithButtons:0x00 withX:0x00 withY:0x00
                                   withScroll:0x00 sendASAP:NO];
        }
        //Button press
        for (int j = 0; j < multiplier; ++j) {
            [self sendCustomReportWithButtons:buttons withX:0x00 withY:0x00
                                   withScroll:0x00 sendASAP:NO];
        }
        //Button release
        for (int k = 0; k < multiplier; ++k) {
            [self sendCustomReportWithButtons:0x00 withX:0x00 withY:0x00
                                   withScroll:0x00 sendASAP:NO];
        }
    }
    [self.inputStickManager.blueToothBuffer sendMouse];
}

@end
