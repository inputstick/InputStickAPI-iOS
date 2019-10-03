/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickRxPacket+FirmwareInfo.h"


@implementation InputStickRxPacket (FirmwareInfo)

- (NSUInteger)firmwareVersion {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return (packetBytes[1] * 100) + packetBytes[2];
}

- (BOOL)passwordProtectionEnabled {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return (packetBytes[18] == 1);
}

- (BOOL)unlocked {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return ((packetBytes[17] & 0x08) != 0);
}

- (BOOL)authenticated {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return ((packetBytes[17] & 0x10) != 0);
}

- (BOOL)isValid {
    return (self.data.length > 18);    
}


@end
