/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "ISKeyboardKeyModel.h"
#import "TxPacket.h"
#import "TxPacket+KeyboardKeyModel.h"


@implementation TxPacket (KeyboardKeyModel)

- (void)addBytesFromKeyboardKeyModel:(ISKeyboardKeyModel *)model {
    NSAssert(self.packetType == PacketTypeQueueSHORTKeyboardReports, @"Incorrect packet type");
    if (model != nil) {
        if (model.deadkey > 0) {
            [self addBytes:(Byte[]) {model.deadkeyModified, 0x00} withLength:2];
            [self addBytes:(Byte[]) {model.deadkeyModified, model.deadkey} withLength:2];
            [self addBytes:(Byte[]) {0x00, 0x00} withLength:2];
        }
        [self addBytes:(Byte[]) {model.modifier, 0x00} withLength:2];
        [self addBytes:(Byte[]) {model.modifier, model.key} withLength:2];
        [self addBytes:(Byte[]) {0x00, 0x00} withLength:2];
    }
    self.packetParam += model.numberOfKeyboardReports;
}

@end
