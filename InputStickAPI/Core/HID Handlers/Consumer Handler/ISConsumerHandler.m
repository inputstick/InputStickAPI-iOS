/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISConsumerHandler.h"
#import "ISManager.h"
#import "ISBluetoothBuffer.h"
#import "ISReport.h"

const Byte CONSUMER_REPORT_ID = 1;
const Byte SYSTEM_REPORT_ID = 2;


@implementation ISConsumerHandler
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

- (void)sendCustomReportWithId:(Byte)reportId withLSBUsage:(Byte)lsbUsage withMSBUsage:(Byte)msbUsage sendASAP:(BOOL)sendASAP {
    ISReport *report = [ISReport consumerReportWithBytes:(Byte[3]) {reportId, lsbUsage, msbUsage}];
    [self.inputStickManager.blueToothBuffer addConsumerReportToQueue:report
                                                            sendASAP:sendASAP];
}

#pragma mark - Consumer actions

- (void)consumerActionWithUsage:(ISConsumerActions)usage {
    Byte msb = (Byte) (usage >> 8);
    Byte lsb = (Byte) (usage & 0x00FF);
    [self sendCustomReportWithId:CONSUMER_REPORT_ID withLSBUsage:lsb withMSBUsage:msb
                        sendASAP:NO];
    [self sendCustomReportWithId:CONSUMER_REPORT_ID withLSBUsage:0x00 withMSBUsage:0x00
                        sendASAP:YES];
}

- (void)systemActionWithUsage:(ISSystemActions)usage {
    Byte msb = (Byte) (usage >> 8);
    Byte lsb = (Byte) (usage & 0x00FF);
    [self sendCustomReportWithId:SYSTEM_REPORT_ID withLSBUsage:lsb withMSBUsage:msb
                        sendASAP:NO];
    [self sendCustomReportWithId:SYSTEM_REPORT_ID withLSBUsage:0x00 withMSBUsage:0x00
                        sendASAP:YES];
}

@end
