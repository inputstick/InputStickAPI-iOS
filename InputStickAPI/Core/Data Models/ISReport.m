/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "ISReport.h"


@interface ISReport ()
@property(nonatomic, strong) NSMutableData *bytesData;
@end

@implementation ISReport

#pragma mark - Object lifecycle

- (instancetype)initWithBytes:(Byte *)bytes withLength:(NSUInteger)length {
    self = [super init];
    if (self) {
        [self setBytes:bytes withLength:length];
    }
    return self;
}

#pragma mark - Property Getter and Setter overrides

- (Byte *)bytes {
    return self.bytesData.bytes;
}

- (void)setBytes:(Byte *)bytes withLength:(NSUInteger)length {
    self.bytesData = [NSMutableData data];
    Byte *bytesTable = self.bytesData.bytes;
    for (int i = 0; i < length; ++i) {
        bytesTable[i] = bytes[i];
    }
    _length = length;
}

#pragma mark - Static object getters

+ (instancetype)keyboardReportWithBytes:(Byte[8])bytes {
    return [[self alloc] initWithBytes:bytes withLength:8];
}

+ (instancetype)shortKeyboardReportWithBytes:(Byte[2])bytes {
    return [[self alloc] initWithBytes:bytes withLength:2];
}

+ (instancetype)mouseReportWithBytes:(Byte[4])bytes {
    return [[self alloc] initWithBytes:bytes withLength:4];
}

+ (instancetype)consumerReportWithBytes:(Byte[3])bytes {
    return [[self alloc] initWithBytes:bytes withLength:3];
}

+ (instancetype)gamePortReportWithBytes:(Byte[6])bytes {
    return [[self alloc] initWithBytes:bytes withLength:6];
}

@end
