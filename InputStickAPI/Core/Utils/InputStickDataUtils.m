/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <stdint.h>
#import "InputStickDataUtils.h"

@implementation InputStickDataUtils

#pragma mark Write data

+ (void)addByte:(Byte)value toData:(NSMutableData *)data {
    unsigned char b[] = {0x00};
    NSData *tmpData;
    b[0] = value;
    tmpData = [NSData dataWithBytes:b length:1];
    [data appendData:tmpData];
}

+ (void)addUInt:(NSUInteger)value toData:(NSMutableData *)data {
    int64_t int64;
    NSData *tmpData;
    int64 = value;
    tmpData = [NSData dataWithBytes:&int64 length:8];
    [data appendData:tmpData];
}

+ (void)addString:(NSString *)value toData:(NSMutableData *)data {
    NSData *tmpData;
    if (value == nil) {
        [self addUInt:0 toData:data];
    } else {
        tmpData = [value dataUsingEncoding:NSUTF8StringEncoding];
        [self addUInt:[tmpData length] toData:data];
        [data appendData:tmpData];
    }
}

+ (void)addData:(NSData *)value toData:(NSMutableData *)data {
    if (value == nil) {
        [self addUInt:0 toData:data];
    } else {
        [self addUInt:[value length] toData:data];
        [data appendData:value];
    }
}


#pragma mark Read data

+ (Byte)readByteFromData:(NSData *)data atLocation:(NSUInteger *)location {
    Byte result;
    NSRange range;
    NSData *tmpData;
    Byte *tmpBytes;
    
    range = NSMakeRange(*location, 1);
    tmpData = [data subdataWithRange:range];
    tmpBytes = (Byte *)tmpData.bytes;
    result = tmpBytes[0];
    *location += 1;
    return result;
}

+ (NSUInteger)readUIntFromData:(NSData *)data atLocation:(NSUInteger *)location {
    NSUInteger result;
    NSRange range;
    NSData *tmpData;
    int64_t int64;
    
    range = NSMakeRange(*location, 8);
    tmpData = [data subdataWithRange:range];
    [tmpData getBytes:&int64 length:8];
    result = (NSUInteger)int64;
    *location += 8;
    return result;
}

+ (NSString *)readStringFromData:(NSData *)data atLocation:(NSUInteger *)location {
    NSString *result = nil;
    NSRange range;
    NSData *tmpData;
    NSUInteger length;
    
    length = [self readUIntFromData:data atLocation:location];
    if (length > 0) {
        range = NSMakeRange(*location, length);
        tmpData = [data subdataWithRange:range];
        result = [[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
        *location += length;
    }
    return result;
}

+ (NSData *)readDataFromData:(NSData *)data atLocation:(NSUInteger *)location {
    NSData *result = nil;
    NSRange range;
    NSUInteger length;
    length = [self readUIntFromData:data atLocation:location];
    if (length > 0) {
        range = NSMakeRange(*location, length);
        result = [data subdataWithRange:range];
        *location += length;
    }
    return result;
}

@end
