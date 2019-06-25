/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickRxPacket.h"
#import "InputStickPacket.h"
#import "InputStickEncryptionManager.h"
#import "NSData+CRC.h"

@interface InputStickRxPacket () {
    NSUInteger _crcCalculated;
    NSUInteger _crcValue;
    NSData *_rawData;
}

@end


@implementation InputStickRxPacket

#pragma mark - Object lifecycle

- (instancetype)initWithData:(NSData *)packetData header:(Byte)header {
    self = [super init];
    if (self) {
        _header = header;
        _command = ((Byte *)packetData.bytes)[4];
        _isNotification = [InputStickPacket isNotification:_command];
        if (_isNotification) {
            _data = [packetData subdataWithRange:NSMakeRange(InputStickPacketNotificationDataOffset, [packetData length] - InputStickPacketNotificationDataOffset)];
        } else {
            _respCode = ((Byte *)packetData.bytes)[5];
            _data = [packetData subdataWithRange:NSMakeRange(InputStickPacketDataOffset, [packetData length] - InputStickPacketDataOffset)];
        }
        
        //check CRC
        NSUInteger crcValue, crcCompare;
        Byte *bytes = ((Byte *)packetData.bytes);
        crcCompare = 0;
        crcCompare += bytes[0];
        crcCompare <<= 8;
        crcCompare += bytes[1];
        crcCompare <<= 8;
        crcCompare += bytes[2];
        crcCompare <<= 8;
        crcCompare += bytes[3];
        if (crcCompare != 0) {
            crcValue = [packetData crc32WithOffset:InputStickPacketCRC32Length length:([packetData length] - InputStickPacketCRC32Length)];
            _crc32Check = (crcValue == crcCompare);
        } else {
            _crc32Check = TRUE;
        }
    }
    return self;
}

@end
