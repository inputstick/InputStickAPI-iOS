/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickGamepadHandler.h"
#import "InputStickManager.h"
#import "InputStickHIDReport.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"


@implementation InputStickGamepadHandler

@synthesize inputStickManager = _inputStickManager;


#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super init];
    if (self) {
        _inputStickManager = manager;
    }
    return self;
}


#pragma mark - Custom Report

- (InputStickHIDReport *)customReportWithButtons:(NSUInteger)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx {
    Byte msb = (Byte) (buttons >> 8);
    Byte lsb = (Byte) (buttons & 0x00FF);
    
    InputStickHIDReport *report = [InputStickHIDReport gamepadReportWithBytes:(Byte[7]) {InputStickGamepadReportID, lsb, msb, x, y, z, rx}];
    return report;
}

- (void)sendCustomReportWithButtons:(NSUInteger)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx {
    InputStickHIDReport *report = [self customReportWithButtons:buttons axisX:x axisY:y axisZ:z axisRX:rx];
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdHIDDataEndpoint withParam:3]; //write directly to endpoint#3 (consumer control endpoint)
    [packet addByte:0x07]; //payload (report) length
    [packet addBytes:report.bytes withLength:report.length];
    [_inputStickManager sendPacket:packet];
}

@end
