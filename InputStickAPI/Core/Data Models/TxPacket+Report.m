/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISReport.h"
#import "TxPacket.h"
#import "TxPacket+Report.h"


@implementation TxPacket (Report)

- (void)addBytesFromReport:(ISReport *)report {
    if ([self isReportPacket]) {
        [self addBytes:report.bytes withLength:report.length];
        self.packetParam += 1;
    } else if ([self isGamepadPacket]) {
        [self addBytes:report.bytes withLength:report.length];
        self.packetParam = 3;
    } else {
        NSAssert([self isReportPacket], @"Incorrect packet type");
    }
}

- (BOOL)isReportPacket {
    return self.packetType == PacketTypeQueueSHORTKeyboardReports ||
            self.packetType == PacketTypeQueueKeyboardReports ||
            self.packetType == PacketTypeQueueMouseReports ||
            self.packetType == PacketTypeQueueConsumerReports;
}

- (BOOL)isGamepadPacket {
    return self.packetType == PacketTypeWriteToEndpoint;
}

@end
