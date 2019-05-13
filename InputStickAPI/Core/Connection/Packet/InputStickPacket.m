/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPacket.h"

Byte const InputStickPacketFlagHMAC = 0x20;
Byte const InputStickPacketFlagEncrypted = 0x40;
Byte const InputStickPacketFlagResponse = 0x80;

NSUInteger const InputStickPacketMaxLength = 17 * 16;
NSUInteger const InputStickPacketCRC32Length = 4;
NSUInteger const InputStickPacketDataOffset = 6;
NSUInteger const InputStickPacketNotificationDataOffset = 5;


@implementation InputStickPacket

+ (BOOL)requiresHMAC:(InputStickCmd)cmd {
    switch (cmd) {
        case CmdHIDStatusReporNoHMAC:
        case CmdHIDDataKeyboardNoHMAC:
        case CmdHIDDataConsumerNoHMAC:
        case CmdHIDDataMouseNoHMAC:
        case CmdHIDDataGamepadNoHMAC:
        case CmdHIDDataMixedNoHMAC:
        case CmdHIDDataTouchScreenNoHMAC:
        case CmdHIDDataRawNoHMAC:
        case CmdHIDDataRawPollNoHMAC:
        case CmdHIDClearNoHMAC:
        case CmdHIDDataEndpointNoHMAC:
        case CmdHIDDataKeyboardShortNoHMAC:
        case CmdHIDDataKeyboardPressAndReleaseNoHMAC:
        case CmdHIDDataQueueNoHMAC:
            return FALSE;
        default:
            return TRUE;
    }
}

+ (BOOL)canEncrypt:(InputStickCmd)cmd {
    switch (cmd) {
        case CmdIdentify:
        case CmdRunFirmware:
        case CmdGetBootloaderInfo:
            
        case 0x06:
        case 0x07:
        case 0x08:
            
        case CmdGetFirmwareInfo:
            
        case CmdAuthenticate:
        case CmdAuthenticateHMAC:
            return FALSE;
        default:
            return TRUE;
    }
}

@end
