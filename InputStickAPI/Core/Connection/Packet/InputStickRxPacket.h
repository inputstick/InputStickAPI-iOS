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

/*! packet header byte */
@property (nonatomic, readonly) Byte header;

/*! packet command byte */
@property (nonatomic, readonly) Byte command;

/*! packet param byte */
@property (nonatomic, readonly) Byte param;

/*! packet bytes (command, param, payload) as NSData */
@property (nonatomic, readonly) NSData *data;

/*! packet bytes (command, param, payload) */
@property (nonatomic, readonly) Byte* bytes;

/*! number of packet bytes */
@property (nonatomic, readonly) NSUInteger length;


- (instancetype)initWithData:(NSData *)data header:(Byte)header;

@end
