/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickMouseHandler.h"
#import "InputStickManager.h"
#import "InputStickHIDReport.h"
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransaction.h"

@implementation InputStickMouseHandler

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

- (InputStickHIDReport *)customReportWithButtons:(Byte)buttons x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)scroll {
    InputStickHIDReport *report = [InputStickHIDReport mouseReportWithBytes:(Byte[4]) {buttons, (Byte) x, (Byte) y, (Byte) scroll}];
    return report;
}

- (void)sendCustomReportWithButtons:(Byte)buttons x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)scroll flush:(BOOL)flush {
    InputStickHIDReport *report = [self customReportWithButtons:buttons x:x y:y scroll:scroll];
    [self.inputStickManager addMouseHIDReport:report flush:flush];
}


#pragma mark - Mouse actions

- (void)moveCursorByX:(SignedByte)x y:(SignedByte)y {
    [self sendCustomReportWithButtons:0x00 x:x y:y scroll:0x00 flush:YES];
}

- (void)scroll:(SignedByte)scroll {
    [self sendCustomReportWithButtons:0x00 x:0x00 y:0x00 scroll:scroll flush:YES];
}

- (void)clickWithButtons:(Byte)buttons numberOfPress:(NSUInteger)numberOfPresses {
    [self clickWithButtons:buttons numberOfPress:numberOfPresses multiplier:1];
}

- (void)clickWithButtons:(Byte)buttons numberOfPress:(NSUInteger)numberOfPresses multiplier:(NSUInteger)multiplier {
    if (multiplier < 1) {
        multiplier = 1;
    }
    InputStickHIDTransaction *transaction = [InputStickHIDTransaction mouseTransaction];
    for (int clickCount = 0; clickCount < numberOfPresses; ++clickCount) {
        //Button release
        for (int i = 0; i < multiplier; ++i) {
            [transaction addHIDReport:[self customReportWithButtons:0x00 x:0x00 y:0x00 scroll:0x00]];
        }
        //Button press
        for (int j = 0; j < multiplier; ++j) {
            [transaction addHIDReport:[self customReportWithButtons:buttons x:0x00 y:0x00 scroll:0x00]];
        }
        //Button release
        for (int k = 0; k < multiplier; ++k) {
            [transaction addHIDReport:[self customReportWithButtons:0x00 x:0x00 y:0x00 scroll:0x00]];
        }
    }
    [self.inputStickManager addMouseHIDTransaction:transaction flush:TRUE];
}

@end
