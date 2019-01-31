/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPacket.h"

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
        case CmdGetFirmwareInfo:
        case CmdRunFirmware:
        case CmdAuthenticate:
        case CmdAuthenticateHMAC:
            return FALSE;
        default:
            return TRUE;
    }
}

@end
