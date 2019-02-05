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

/*! packet bytes (command, param, payload) as NSData */
@property (nonatomic, readonly) NSData *data;

/*! packet bytes (command, param, payload) */
@property (nonatomic, readonly) Byte* bytes;

/*! number of packet bytes */
@property (nonatomic, readonly) NSUInteger length;

/*! if TRUE, CRC32 check was passed */
@property (nonatomic, readonly) BOOL crc32CheckPassed;

/*! if TRUE, the packet was received in encrypted form */
@property (nonatomic, readonly) BOOL encrypted;


- (instancetype)initWithRawData:(NSData *)rawData header:(Byte)header;

/*!
 @brief decrypt content of the packet
 @param encryptionManager encryptionManager that will be used to decrypt the packet
 */
- (void)decryptWithEncryptionManager:(InputStickEncryptionManager *)encryptionManager;

@end
