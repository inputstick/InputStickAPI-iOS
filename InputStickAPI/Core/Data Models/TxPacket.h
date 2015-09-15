//
// Created by Marcin Wieclawski on 11/07/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISKeyboardKeyModel;

typedef NS_ENUM(NSInteger, PacketTypes) {
    PacketTypeRunFirmware = 0x04,                   //Run firmware                      No param
    PacketTypeGetFirmwareInfo = 0x10,               //Get firmware info                 No param
    PacketTypeResetReportBuffers = 0x11,
    PacketTypeAuthenticate = 0x12,                  //Authenticate                      Enable outgoing encryption (currently ignored!)
    PacketTypeSettings = 0x14,
    PacketTypeRestoreDefaults = 0x15,
    PacketTypeReadSettings = 0x17,
    PacketTypeSetPIN = 0x18,
    PacketTypeUSBResume = 0x19,                     //USB Resume                        No param
    PacketTypeUSBPower = 0x1A,
    PacketTypeUnlock = 0x1B,
    PacketTypeQueueKeyboardReports = 0x21,
    PacketTypeQueueConsumerReports = 0x22,          //Default for Consume reports       Number of reports
    PacketTypeQueueMouseReports = 0x23,             //Default for Mouse Reports         Number of reports
    PacketTypeQueueGamepadReports = 0x24,           //Default for Gamepad               Number of reports
    PacketTypeWriteToEndpoint = 0x2B,
    PacketTypeQueueSHORTKeyboardReports = 0x2C,     //Default for Keyboard Reports      Number of reports
    PacketTypeQueuePressAndReleaseEvents = 0x2D
};

@interface TxPacket : NSObject
@property(nonatomic) PacketTypes packetType;
@property(nonatomic) Byte packetParam;
@property(nonatomic) BOOL requiresResponse;
@property(nonatomic) BOOL usesEncryption;
@property(nonatomic) NSMutableArray *inputDataBytes;

@property(nonatomic) NSData *dataBytes;

- (instancetype)initWithPacketType:(PacketTypes)packetType;

- (NSData *)getPacketWithResponse:(BOOL)requiresResponse withEncryption:(BOOL)useEncryption;

- (void)addByte:(Byte)byte;

- (void)addBytes:(Byte *)bytes withLength:(NSUInteger)length;

@end
