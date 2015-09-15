//
// Created by Marcin Wieclawski on 13/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISDeviceBuffersState : NSObject
@property(nonatomic) NSInteger sendKeyboardReports;
@property(nonatomic) NSInteger sendMouseReports;
@property(nonatomic) NSInteger sendConsumerReports;

@end
