/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISGamepadHandler.h"
#import "ISReport.h"
#import "ISManager.h"
#import "ISBluetoothBuffer.h"


@implementation ISGamepadHandler
@synthesize inputStickManager = _inputStickManager;

- (instancetype)initWithManager:(ISManager *)manager {
    self = [super init];
    if (self) {
        _inputStickManager = manager;
    }
    return self;
}

#pragma mark - Custom Report

- (void)sendCustomReportWithButtons:(GamepadButtons)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx {
    Byte msb = (Byte) (buttons >> 8);
    Byte lsb = (Byte) (buttons & 0x00FF);

    ISReport *reportModel = [ISReport gamepadReportWithBytes:(Byte[8]) {0x07, 0x03, lsb, msb, x, y, z, rx}];
    [self.inputStickManager.blueToothBuffer sendGamepadReport:reportModel];
}

@end
