//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketFactory.h"

@class TxPacket;


@interface ISConnectionPacketFactory : NSObject<PacketFactory>

- (instancetype)initWithManager:(ISManager *)manager;

- (TxPacket *)prepareRunFirmwarePacket;

- (TxPacket *)prepareGetFirmwareInfoPacket;

- (TxPacket *)prepareAuthenticatePacket;

@end
