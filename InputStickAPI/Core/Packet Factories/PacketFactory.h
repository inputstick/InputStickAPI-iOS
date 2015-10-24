//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISManager;

@protocol PacketFactory <NSObject>
@property(nonatomic, strong) ISManager *manager;

@end
