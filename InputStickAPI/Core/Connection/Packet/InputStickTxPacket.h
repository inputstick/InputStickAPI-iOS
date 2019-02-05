/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickTxPacket.h
 @brief packet that can be sent to InputStick
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(Byte, InputStickCmd);
@class InputStickEncryptionManager;

@interface InputStickTxPacket : NSObject

/*! command byte */
@property(nonatomic) InputStickCmd command;

/*! parameter byte */
@property(nonatomic) Byte param;

/*! if TRUE, InputStick will respond to this packet (confirmation) */
@property(nonatomic) BOOL requiresResponse;

/*! payload bytes */
@property(nonatomic) NSMutableArray<NSNumber *> *inputDataBytes;

#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd;

- (instancetype)initWithCmd:(InputStickCmd)cmd withParam:(Byte)param;


#pragma mark - Adding data

/*!
 @brief adds byte to packet
 @param byte byte to add
 */
- (void)addByte:(Byte)byte;

/*!
 @brief adds bytes to packet
 @param bytes bytes to add
 @param length number of bytes to add
 */
- (void)addBytes:(Byte *)bytes withLength:(NSUInteger)length;


#pragma mark - Getting Data

/*!
 @brief returns packet as raw bytes that can be sent to InputStick
 @return raw data bytes
 */
- (NSData *)getRawData;

/*!
 @brief returns packet as raw bytes (encrypted), that can be sent to InputStick
 @param encryptionManager encryptionManager that will be used to encrypt the packet
 @return raw data bytes (encrypted)
 */
- (NSData *)getRawDataWithEncryptionManager:(InputStickEncryptionManager *)encryptionManager;

@end
