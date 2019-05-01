/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

@interface InputStickDataUtils : NSObject

#pragma mark Write data

+ (void)addByte:(Byte)value toData:(NSMutableData *)data;

+ (void)addUInt:(NSUInteger)value toData:(NSMutableData *)data;

+ (void)addString:(NSString *)value toData:(NSMutableData *)data;

+ (void)addData:(NSData *)value toData:(NSMutableData *)data;

    
#pragma mark Read data

+ (Byte)readByteFromData:(NSData *)data atLocation:(NSUInteger *)location;

+ (NSUInteger)readUIntFromData:(NSData *)data atLocation:(NSUInteger *)location;

+ (NSString *)readStringFromData:(NSData *)data atLocation:(NSUInteger *)location;
    
+ (NSData *)readDataFromData:(NSData *)data atLocation:(NSUInteger *)location;

@end
