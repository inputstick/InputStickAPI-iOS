/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTxPacket.h"
#import "InputStickPacket.h"
#import "NSData+CRC.h"

@implementation InputStickTxPacket

#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd {
    return [self initWithCmd:cmd withParam:0];
}

- (instancetype)initWithCmd:(InputStickCmd)cmd withParam:(Byte)param {
    self = [super init];
    if (self) {
        _remainingBytes = InputStickPacketMaxLength - InputStickPacketDataOffset; //crc(4B)+cmd+param
        self.data = [NSMutableArray array];
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
        [self.data addObject:@(byte)];
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
            [self.data addObject:number];
        }
        return TRUE;
    } else {
        return FALSE;
    }
}


#pragma mark - Getting Data

- (NSMutableData *)getPacketData {
    NSUInteger payloadLength = self.data.count + InputStickPacketDataOffset;
    NSUInteger totalLength = (((payloadLength - 1) >> 4) + 1) * 16; //adds padding if necessary
    
    NSMutableData *result = [NSMutableData dataWithLength:totalLength];
    Byte *resultBytes = (Byte *)result.bytes;
    resultBytes[4] = _command;
    resultBytes[5] = _param;
    for (NSUInteger i = 0; i < self.data.count; i++) {
        NSNumber *number = self.data[i];
        resultBytes[i + InputStickPacketDataOffset] = (Byte)[number integerValue];
    }
    //add CRC32
    NSUInteger crcValue = [result crc32WithOffset:InputStickPacketCRC32Length length:(totalLength - InputStickPacketCRC32Length)];
    resultBytes[3] = (Byte) crcValue;
    crcValue >>= 8;
    resultBytes[2] = (Byte) crcValue;
    crcValue >>= 8;
    resultBytes[1] = (Byte) crcValue;
    crcValue >>= 8;
    resultBytes[0] = (Byte) crcValue;
    return result;
}






@end
