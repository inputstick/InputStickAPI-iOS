/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickPacketFactory.h
 @brief used to parse received bytes into packets and create outgoing packets
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InputStickErrorCode);
@class InputStickTxPacket;
@class InputStickRxPacket;
@class InputStickManager;

typedef NS_ENUM(NSUInteger, InputStickResponseParsingState) {
    InputStickResponseParsingStateTag,
    InputStickResponseParsingStateHeader,
    InputStickResponseParsingStateData
};

typedef NS_ENUM(NSUInteger, InputStickPacketParsingResult) {
    InputStickPacketParsingStarted,
    InputStickPacketParsingInProgress,
    InputStickPacketParsingDone,
    InputStickPacketParsingError
};


@interface InputStickPacketFactory : NSObject

@property(nonatomic, readonly) InputStickRxPacket *parsedPacket;
@property(nonatomic, readonly) InputStickErrorCode errorCode;

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

#pragma mark - RX Packet

- (void)resetRxState;
- (InputStickPacketParsingResult)parseResponseByte:(Byte)responseByte;
- (BOOL)verifyPacket:(InputStickRxPacket *)rxPacket inputStickManager:(InputStickManager *)inputStickManager;

#pragma mark - TX Packet
    
- (InputStickTxPacket *)prepareRunFirmwarePacket;
- (InputStickTxPacket *)prepareGetFirmwareInfoPacket;
- (InputStickTxPacket *)prepareSetUpdateIntervalPacketWithParam:(Byte)param;


#pragma mark - Authentication Packet

- (InputStickTxPacket *)prepareAuthenticatePacket:(BOOL)hmacEnabledDevice;
- (BOOL)verifyAuthenticationResponsePacket:(InputStickRxPacket *)rxPacket;

@end
