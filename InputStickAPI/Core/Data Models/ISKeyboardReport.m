/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISKeyboardReport.h"


@interface ISKeyboardReport ()
@property(nonatomic, strong) NSMutableData *bytesData;
@end

@implementation ISKeyboardReport

- (instancetype)initWithBytes:(Byte[8])bytes {
    self = [super init];
    if (self) {
        [self setBytes:bytes withLength:8];
    }
    return self;
}

- (instancetype)initWithShortReportBytes:(Byte[2])bytes {
    self = [super init];
    if (self) {
        [self setBytes:bytes withLength:2];
    }
    return self;
}

#pragma mark - Bytes Getter

- (Byte *)bytes {
    return self.bytesData.bytes;
}

#pragma mark - Bytes Setter

- (void)setBytes:(Byte *)bytes withLength:(NSUInteger)length {
    self.bytesData = [NSMutableData data];
    Byte *bytesTable = self.bytesData.bytes;
    for (int i = 0; i < length; ++i) {
        bytesTable[i] = bytes[i];
    }
    _length = length;
}

@end
