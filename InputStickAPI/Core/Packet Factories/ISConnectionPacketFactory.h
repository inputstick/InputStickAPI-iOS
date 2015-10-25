//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISPacketFactory.h"

@class TxPacket;


@interface ISConnectionPacketFactory : NSObject<ISPacketFactory>

- (instancetype)initWithManager:(ISManager *)manager;

- (TxPacket *)prepareRunFirmwarePacket;

- (TxPacket *)prepareGetFirmwareInfoPacket;

- (TxPacket *)prepareAuthenticatePacket;

@end
