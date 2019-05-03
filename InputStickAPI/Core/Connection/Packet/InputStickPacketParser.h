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
@class InputStickRxPacket;
@class InputStickManager;

typedef NS_ENUM(NSUInteger, InputStickPacketParsingState) {
    InputStickPacketParsingStateTag,
    InputStickPacketParsingStateHeader,
    InputStickPacketParsingStatePayload,
    InputStickPacketParsingStateDisabled
};

typedef NS_ENUM(NSUInteger, InputStickPacketParsingResult) {
    InputStickPacketParsingResultInProgress,
    InputStickPacketParsingResultStarted,
    InputStickPacketParsingResultDone,
    InputStickPacketParsingResultError
};


@interface InputStickPacketParser : NSObject

@property(nonatomic, readonly) InputStickRxPacket *parsedPacket;
@property(nonatomic, readonly) InputStickErrorCode errorCode;

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

#pragma mark - RX Packet

- (void)resetRxState;
- (InputStickPacketParsingResult)parseResponseByte:(Byte)responseByte;

@end
