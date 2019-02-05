/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickRxPacket+FirmwareInfo.h"


@implementation InputStickRxPacket (FirmwareInfo)

- (NSUInteger)firmwareVersion {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return (packetBytes[3] * 100) + packetBytes[4];
}

- (BOOL)passwordProtectionEnabled {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return (packetBytes[20] == 1);
}

- (BOOL)unlocked {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return ((packetBytes[19] & 0x08) != 0);
}

- (BOOL)authenticated {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return ((packetBytes[19] & 0x10) != 0);
}


@end
