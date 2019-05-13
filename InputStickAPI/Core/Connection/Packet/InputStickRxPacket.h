/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickRxPacket.h
 @brief packet received from InputStick
 */

#import <Foundation/Foundation.h>

@class InputStickEncryptionManager;

@interface InputStickRxPacket : NSObject

/*! result of CRC32 check */
@property (nonatomic, readonly) BOOL crc32Check;

/*! if TRUE, this packet is a notification packet (not reponse packet) */
@property (nonatomic, readonly) BOOL isNotification;

/*! packet header byte */
@property (nonatomic, readonly) Byte header;

/*! packet command byte */
@property (nonatomic, readonly) Byte command;

/*! packet response code byte */
@property (nonatomic, readonly) Byte respCode;

/*! packet data bytes */
@property (nonatomic, readonly) NSData *data;


- (instancetype)initWithData:(NSData *)data header:(Byte)header;

@end
