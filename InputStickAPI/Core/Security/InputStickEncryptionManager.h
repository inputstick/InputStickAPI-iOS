/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickEncryptionManager.h
 @brief manages encryption for incoming and outgoing packets and device authentication
 */

#import <Foundation/Foundation.h>

//remove if you don't want to enable encryption support in your application (AppStore regulations)
#define INPUTSTICK_CRYPTO_ENABLED

@class InputStickTxPacket;
@class InputStickRxPacket;

@interface InputStickEncryptionManager : NSObject

@property(nonatomic, strong, readonly) NSData *iv;
@property(nonatomic, readonly) BOOL hmacEnabled;

#pragma mark - Static methods

+ (BOOL)isSupported;


#pragma mark - Setup

- (void)resetStateWithKey:(NSData *)key;


#pragma mark - Encryption

- (NSData *)encryptData:(NSData *)data;
- (NSData *)encryptBytes:(Byte *)bytes withLength:(NSUInteger)length;
- (NSData *)decryptData:(NSData *)data;
- (NSData *)decryptBytes:(Byte *)bytes withLength:(NSUInteger)length;


#pragma mark - Challenge response

- (NSData *)prepareChallengeData;
- (BOOL)verifyChallengeResponse:(NSData *)response;


#pragma mark - HMAC

- (void)initHMACWithKey:(NSData *)key;
- (NSData *)getHMACForData:(NSData *)data;


#pragma mark - Encryption Packets

- (InputStickTxPacket *)prepareAuthenticatePacket:(BOOL)hmacEnabledDevice;
- (BOOL)verifyAuthenticationResponsePacket:(InputStickRxPacket *)rxPacket;

#pragma mark - Encryption Helpers

+ (NSData *)randomDataWithLength:(NSUInteger)length;
+ (NSData *)MD5FromString:(NSString *)input;

@end
