//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISReport : NSObject
@property(nonatomic, readonly) Byte *bytes;
@property(nonatomic, readonly) NSUInteger length;

+ (instancetype)keyboardReportWithBytes:(Byte[8])bytes;

//Keyboard report length: 2B [modifier, key]
+ (instancetype)shortKeyboardReportWithBytes:(Byte[2])bytes;

//Mouse report length: 4B [buttons, dx, dy, scroll]
+ (instancetype)mouseReportWithBytes:(Byte[4])bytes;

//Consumer report length: 3B [report_id, usage_lsb, usage_msb]
+ (instancetype)consumerReportWithBytes:(Byte[3])bytes;

//GamePort report length: 6B [buttons1, buttons2, x, y, z, rX]
+ (instancetype)gamePortReportWithBytes:(Byte[6])bytes;

@end
