/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickRxPacket+HIDUpdate.h"
#import "InputStickManager.h"

@implementation InputStickRxPacket (HIDUpdate)

- (InputStickUSBState)usbState {
    Byte* packetBytes = (Byte *)self.data.bytes;
    return packetBytes[1];
}

@end
