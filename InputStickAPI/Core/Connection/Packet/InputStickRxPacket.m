/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickRxPacket.h"
#import "InputStickEncryptionManager.h"
#import "NSData+CRC.h"

@interface InputStickRxPacket () {
    NSUInteger _crcCalculated;
    NSUInteger _crcValue;
    NSData *_rawData;
}

@end


@implementation InputStickRxPacket

- (instancetype)initWithRawData:(NSData *)rawData header:(Byte)header {
    self = [super init];
    if (self) {
        _rawData = rawData;
        _header = header;
        
        if (_header & 0x40) {
            //packet is encrypted, decryptWithEncryptionManager must be called 
        } else {
            _data = [NSMutableData data];
            _data = [_rawData subdataWithRange:NSMakeRange(4, [_rawData length] - 4)];
            _command = ((Byte *)_data.bytes)[0];
        }
    }
    return self;
}

- (BOOL)encrypted {
    return (_header & 0x40);
}

- (void)decryptWithEncryptionManager:(InputStickEncryptionManager *)encryptionManager {
    if (self.encrypted) {
        _rawData = [encryptionManager decryptData:_rawData];
        _data = [NSMutableData data];
        _data = [_rawData subdataWithRange:NSMakeRange(4, [_rawData length] - 4)];
        _command = ((Byte *)_data.bytes)[0];
    }
}

- (BOOL)crc32CheckPassed {
    Byte *rawBytes = (Byte *)_rawData.bytes;
    _crcValue = 0;
    _crcValue += rawBytes[0];
    _crcValue <<= 8;
    _crcValue += rawBytes[1];
    _crcValue <<= 8;
    _crcValue += rawBytes[2];
    _crcValue <<= 8;
    _crcValue += rawBytes[3];
    if (_crcValue != 0) {
        _crcCalculated = [_rawData crc32WithOffset:4 length:([_rawData length] - 4)];
        if (_crcValue != _crcCalculated) {
            return FALSE;
        }
    }
    return TRUE;
}

- (Byte *)bytes {
    return (Byte *)self.data.bytes;
}

- (NSUInteger)length {
    return [self.data length];
}

@end
