/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISReport.h"
#import "TxPacket.h"
#import "TxPacket+Report.h"


@implementation TxPacket (Report)

- (void)addBytesFromReport:(ISReport *)report {
    NSAssert([self isReportPacket], @"Incorrect packet type");
    if (report != nil) {
        [self addBytes:report.bytes withLength:report.length];
    }
    self.packetParam += 1;
}

- (BOOL)isReportPacket {
    PacketTypes packetType = self.packetType;
    return packetType == PacketTypeQueueSHORTKeyboardReports ||
            packetType == PacketTypeQueueKeyboardReports ||
            packetType == PacketTypeQueueMouseReports;
}

@end
