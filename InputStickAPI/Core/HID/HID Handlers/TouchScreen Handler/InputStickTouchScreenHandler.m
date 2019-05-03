/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTouchScreenHandler.h"
#import "InputStickManager.h"
#import "InputStickHIDReport.h"
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransaction.h"

@implementation InputStickTouchScreenHandler

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

- (InputStickHIDReport *)customReportWithTipSwitch:(BOOL)tipSwitch inRange:(BOOL)inRange x:(NSUInteger)x y:(NSUInteger)y {
    Byte b = 0;
    if (tipSwitch) {
        b = 1;
    }
    if (inRange) {
        b += 2;
    }
    Byte msbX = (Byte) (x >> 8);
    Byte lsbX = (Byte) (x & 0x00FF);
    Byte msbY = (Byte) (y >> 8);
    Byte lsbY = (Byte) (y & 0x00FF);
    
    InputStickHIDReport *report = [InputStickHIDReport touchScreenReportWithBytes:(Byte[6]) {InputStickTouchScreenReportID, b, lsbX, msbX, lsbY, msbY}];
    return report;
}

- (void)sendCustomReportWithTipSwitch:(BOOL)tipSwitch inRange:(BOOL)inRange x:(NSUInteger)x y:(NSUInteger)y flush:(BOOL)flush {
    InputStickHIDReport *report = [self customReportWithTipSwitch:tipSwitch inRange:inRange x:x y:y];
    [self.inputStickManager addConsumerHIDReport:report flush:flush];
}


#pragma mark - TouchScreen actions

- (void)moveTouchPointerToX:(NSUInteger)x y:(NSUInteger)y withButtonPressed:(BOOL)button {
    [self sendCustomReportWithTipSwitch:button inRange:TRUE x:x y:y flush:YES];
}

- (void)clickAtX:(NSUInteger)x y:(NSUInteger)y numberOfTimes:(NSUInteger)n {
    InputStickHIDTransaction *transaction = [InputStickHIDTransaction touchScreenTransaction];
    for (int i = 0; i < n; i++) {
        //Button release
        [transaction addHIDReport:[self customReportWithTipSwitch:FALSE inRange:TRUE x:x y:y]];
        //Button press
        [transaction addHIDReport:[self customReportWithTipSwitch:TRUE inRange:TRUE x:x y:y]];
        //Button release
        [transaction addHIDReport:[self customReportWithTipSwitch:FALSE inRange:TRUE x:x y:y]];
    }
    [self.inputStickManager addConsumerHIDTransaction:transaction flush:YES];
}

- (void)goOutOfRangeAtX:(NSUInteger)x y:(NSUInteger)y {
    [self sendCustomReportWithTipSwitch:FALSE inRange:FALSE x:x y:y flush:YES];
}


@end
