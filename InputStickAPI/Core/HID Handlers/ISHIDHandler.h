//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISManager;

@protocol ISHIDHandler <NSObject>
@property(nonatomic, readonly) ISManager *inputStickManager;

@end
