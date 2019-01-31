/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickConsumerHandler.h"
#import "InputStickManager.h"
#import "InputStickHIDReport.h"
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransaction.h"

@implementation InputStickConsumerHandler

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

- (InputStickHIDReport *)customReportWithId:(InputStickReportID)reportId LSBUsage:(Byte)lsbUsage MSBUsage:(Byte)msbUsage {
    InputStickHIDReport *report = [InputStickHIDReport consumerReportWithBytes:(Byte[3]) {reportId, lsbUsage, msbUsage}];
    return report;
}

- (void)sendCustomReportWithId:(InputStickReportID)reportId LSBUsage:(Byte)lsbUsage MSBUsage:(Byte)msbUsage sendASAP:(BOOL)sendASAP {
    InputStickHIDReport *report = [self customReportWithId:reportId LSBUsage:lsbUsage MSBUsage:msbUsage];
    [self.inputStickManager addConsumerHIDReport:report sendASAP:sendASAP];
}


#pragma mark - Consumer actions

- (void)consumerActionWithUsage:(InputStickConsumerActions)usage {
    Byte msb = (Byte) (usage >> 8);
    Byte lsb = (Byte) (usage & 0x00FF);
    InputStickHIDTransaction *transaction = [InputStickHIDTransaction consumerTransaction];
    [transaction addHIDReport:[self customReportWithId:InputStickConsumerReportID LSBUsage:lsb MSBUsage:msb]];
    [transaction addHIDReport:[self customReportWithId:InputStickConsumerReportID LSBUsage:0x00 MSBUsage:0x00]];
    [self.inputStickManager addConsumerHIDTransaction:transaction sendASAP:YES];
}

- (void)systemActionWithUsage:(InputStickSystemActions)usage {
    Byte msb = (Byte) (usage >> 8);
    Byte lsb = (Byte) (usage & 0x00FF);
    InputStickHIDTransaction *transaction = [InputStickHIDTransaction consumerTransaction];
    [transaction addHIDReport:[self customReportWithId:InputStickSystemReportID LSBUsage:lsb MSBUsage:msb]];
    [transaction addHIDReport:[self customReportWithId:InputStickSystemReportID LSBUsage:0x00 MSBUsage:0x00]];
    [self.inputStickManager addConsumerHIDTransaction:transaction sendASAP:YES];
}

@end
