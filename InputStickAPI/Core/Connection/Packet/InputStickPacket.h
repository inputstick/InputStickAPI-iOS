/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

extern Byte const InputStickPacketFlagHMAC;
extern Byte const InputStickPacketFlagEncrypted;
extern Byte const InputStickPacketFlagResponse;

extern NSUInteger const InputStickPacketMaxLength;
extern NSUInteger const InputStickPacketCRC32Length;
extern NSUInteger const InputStickPacketDataOffset;
extern NSUInteger const InputStickPacketNotificationDataOffset;


typedef NS_ENUM(Byte, InputStickCmd) {
    CmdIdentify =                               0x01,
    CmdRunBootloader =                          0x03,
    CmdRunFirmware =                            0x04,
    CmdGetBootloaderInfo =                      0x05,
    
    CmdGetFirmwareInfo =                        0x10,
    CmdWdgReset =                               0x11,
    CmdAuthenticate =                           0x12,
    CmdSetValue =                               0x14,
    CmdRestoreDefaults =                        0x15,
    CmdGetValue =                               0x17,
    CmdSetPIN =                                 0x18,
    CmdUSBResume =                              0x19,
    CmdUSBPower =                               0x1A,
    CmdSetName =                                0x1C,
    CmdErrorNotification =                      0x1E, //(FW1.00+)
    CmdSystemNotification =                     0x1F,
    
    CmdHIDRequestStatusReport =                 0x20,
    CmdHIDDataKeyboard =                        0x21,
    CmdHIDDataConsumer =                        0x22,
    CmdHIDDataMouse =                           0x23,
    CmdHIDDataGamepad =                         0x24,
    CmdHIDDataMixed =                           0x25,
    CmdHIDDataTouchScreen =                     0x26,
    CmdHIDDataRaw =                             0x27,
    CmdHIDDataRawPoll =                         0x28,
    CmdHIDClear =                               0x2A,
    CmdHIDDataEndpoint =                        0x2B,
    CmdHIDDataKeyboardShort =                   0x2C,
    CmdHIDDataKeyboardPressAndRelease =         0x2D,
    CmdHIDDataQueue =                           0x2E, //(FW1.01+)
    CmdHIDStatusNotification =                  0x2F,
    
    CmdAuthenticateHMAC =                       0x30, //(FW1.00+)
    CmdSetUpdateInterval =                      0x31, //(FW1.00+)
    CmdGetStatus =                              0x32, //(FW1.00+)
    
    CmdKeygenGenerate =                         0x33, //(FW1.01+)
    CmdKeygenTest =                             0x34, //(FW1.01+)
    CmdKeygenVerify =                           0x35, //(FW1.01+)
    CmdKeygenNotification =                     0x36, //(FW1.01+)
    
    CmdHIDStatusReporNoHMAC =                   0x40, //(FW1.01+)
    CmdHIDDataKeyboardNoHMAC =                  0x41, //(FW1.01+)
    CmdHIDDataConsumerNoHMAC =                  0x42, //(FW1.01+)
    CmdHIDDataMouseNoHMAC =                     0x43, //(FW1.01+)
    CmdHIDDataGamepadNoHMAC =                   0x44, //(FW1.01+)
    CmdHIDDataMixedNoHMAC =                     0x45, //(FW1.01+)
    CmdHIDDataTouchScreenNoHMAC =               0x46, //(FW1.01+)
    CmdHIDDataRawNoHMAC =                       0x47, //(FW1.01+)
    CmdHIDDataRawPollNoHMAC =                   0x48, //(FW1.01+)
    CmdHIDClearNoHMAC =                         0x4A, //(FW1.01+)
    CmdHIDDataEndpointNoHMAC =                  0x4B, //(FW1.01+)
    CmdHIDDataKeyboardShortNoHMAC =             0x4C, //(FW1.01+)
    CmdHIDDataKeyboardPressAndReleaseNoHMAC =   0x4D, //(FW1.01+)
    CmdHIDDataQueueNoHMAC =                     0x4E, //(FW1.01+)
};


@interface InputStickPacket : NSObject

+ (BOOL)requiresHMAC:(InputStickCmd)cmd;

+ (BOOL)canEncrypt:(InputStickCmd)cmd;

@end

