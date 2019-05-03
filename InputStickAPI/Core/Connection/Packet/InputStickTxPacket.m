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
        _remainingBytes = (16 * 17) - 6; //crc(4B)+cmd+param
        self.dataBytes = [NSMutableArray array];
        self.requiresResponse = NO;
        _command = cmd;
        _param = param;
    }
    return self;
}


#pragma mark - Adding data

- (BOOL)addByte:(Byte)byte {
    if (_remainingBytes >= 1) {
        _remainingBytes -= 1;
        [self.dataBytes addObject:@(byte)];
        return TRUE;
    } else {
        return FALSE;
    }
}

- (BOOL)addBytes:(Byte *)bytes withLength:(NSUInteger)length {
    if (_remainingBytes >= length) {
        _remainingBytes -= length;
        for (int i = 0; i < length; i++) {
            NSNumber *number = @(bytes[i]);
            [self.dataBytes addObject:number];
        }
        return TRUE;
    } else {
        return FALSE;
    }
}


#pragma mark - Getting Data

- (NSData *)getData {
    NSUInteger length = 2 + self.dataBytes.count; //cmd+param+data
    NSMutableData *packetData = [NSMutableData dataWithLength:length];
    Byte *packetBytes = (Byte *)packetData.bytes;
    //copy cmd+param
    packetBytes[0] = self.command;
    packetBytes[1] = self.param;
    //copy data
    for (NSUInteger i = 0; i < self.dataBytes.count; ++i) {
        NSNumber *number = self.dataBytes[i];
        packetBytes[i + 2] = (Byte)[number integerValue];
    }
    return packetData;
}


@end
