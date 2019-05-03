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

/*! remaining free space */
@property(nonatomic, readonly) NSUInteger remainingBytes;

/*! command byte */
@property(nonatomic) InputStickCmd command;

/*! parameter byte */
@property(nonatomic) Byte param;

/*! data bytes */
@property(nonatomic) NSMutableArray<NSNumber *> *dataBytes;

/*! if TRUE, InputStick will respond to this packet (confirmation) */
@property(nonatomic) BOOL requiresResponse;


#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd;

- (instancetype)initWithCmd:(InputStickCmd)cmd withParam:(Byte)param;


#pragma mark - Adding data

/*!
 @brief adds byte to packet (if there is enough available free bytes remaining)
 @param byte byte to add
 @return TRUE if added
 */
- (BOOL)addByte:(Byte)byte;

/*!
 @brief adds bytes to packet (if there is enough available free bytes remaining)
 @param bytes bytes to add
 @param length number of bytes to add
 @return TRUE if added
 */
- (BOOL)addBytes:(Byte *)bytes withLength:(NSUInteger)length;


#pragma mark - Getting Data

/*!
 @brief returns packet content (command, param, data bytes) as NSData
 @return packet content as NSData
 */
- (NSData *)getData;


@end
