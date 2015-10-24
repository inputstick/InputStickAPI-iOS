/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISConnectionPacketFactory.h"
#import "ISManager.h"
#import "TxPacket.h"


@implementation ISConnectionPacketFactory
@synthesize manager = _manager;

- (instancetype)initWithManager:(ISManager *)manager {
    self = [super init];
    if (self) {
        self.manager = manager;
    }
    return self;
}

- (TxPacket *)prepareRunFirmwarePacket {
    TxPacket *runFirmwarePacket = [[TxPacket alloc] initWithPacketType:PacketTypeRunFirmware];
    runFirmwarePacket.requiresResponse = YES;
    return runFirmwarePacket;
}

- (TxPacket *)prepareGetFirmwareInfoPacket {
    TxPacket *getFirmwareInfo = [[TxPacket alloc] initWithPacketType:PacketTypeGetFirmwareInfo];
    getFirmwareInfo.requiresResponse = YES;
    return getFirmwareInfo;
}

- (TxPacket *)prepareAuthenticatePacket {
    TxPacket *authenticatePacket = [[TxPacket alloc] initWithPacketType:PacketTypeAuthenticate];
    authenticatePacket.requiresResponse = YES;
    return authenticatePacket;
}

@end
