/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
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

#pragma mark - Object lifecycle

- (instancetype)initWithData:(NSData *)data header:(Byte)header {
    self = [super init];
    if (self) {
        _header = header;
        _data = data;
        _command = ((Byte *)_data.bytes)[0];
        _param = ((Byte *)_data.bytes)[1];
    }
    return self;
}


- (Byte *)bytes {
    return (Byte *)self.data.bytes;
}

- (NSUInteger)length {
    return [self.data length];
}

@end
