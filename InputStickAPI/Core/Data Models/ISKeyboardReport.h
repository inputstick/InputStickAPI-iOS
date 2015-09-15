//
// Created by Marcin Wieclawski on 14/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISKeyboardReport : NSObject
@property(nonatomic, readonly) Byte *bytes;
@property(nonatomic, readonly) NSUInteger length;

- (instancetype)initWithBytes:(Byte[8])bytes;

- (instancetype)initWithShortReportBytes:(Byte[2])bytes;

@end
