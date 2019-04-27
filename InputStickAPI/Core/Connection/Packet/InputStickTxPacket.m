/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTxPacket.h"
#import "InputStickPacket.h"


@implementation InputStickTxPacket

#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd {
    return [self initWithCmd:cmd withParam:0];
}

- (instancetype)initWithCmd:(InputStickCmd)cmd withParam:(Byte)param {
    self = [super init];
    if (self) {
        self.command = cmd;
        self.param = param;
        self.inputDataBytes = [NSMutableArray array];
        self.requiresResponse = NO;
    }
    return self;
}


#pragma mark - Adding data

- (void)addByte:(Byte)byte {
    [self.inputDataBytes addObject:@(byte)];
}

- (void)addBytes:(Byte *)bytes withLength:(NSUInteger)length {
    for (int i = 0; i < length; i++) {
        NSNumber *number = @(bytes[i]);
        [self.inputDataBytes addObject:number];
    }
}


#pragma mark - Getting Data

- (NSData *)getData {
    NSUInteger length = 2 + self.inputDataBytes.count; //cmd+param+payload
    NSMutableData *packetData = [NSMutableData dataWithLength:length];
    Byte *packetBytes = (Byte *)packetData.bytes;
    //copy cmd+param
    packetBytes[0] = self.command;
    packetBytes[1] = self.param;
    //copy payload
    for (NSUInteger i = 0; i < self.inputDataBytes.count; ++i) {
        NSNumber *number = self.inputDataBytes[i];
        packetBytes[i + 2] = (Byte)[number integerValue];
    }
    return packetData;
}

- (NSArray<NSNumber *> *)getPayloadBytesArray {
    return self.inputDataBytes;
}



@end
