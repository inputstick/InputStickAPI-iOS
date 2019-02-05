/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTxPacket.h"
#import "InputStickPacket.h"
#import "InputStickEncryptionManager.h"
#import "NSData+CRC.h"


@implementation InputStickTxPacket

#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd {
    return [self initWithCmd:cmd withParam:0];
}

- (instancetype)initWithCmd:(InputStickCmd)cmd withParam:(Byte)param {
    self = [super init];
    if (self) {
        self.command = cmd;
        self.param = param;
        self.inputDataBytes = [NSMutableArray array];
        self.requiresResponse = NO;
    }
    return self;
}


#pragma mark - Adding data

- (void)addByte:(Byte)byte {
    [self.inputDataBytes addObject:@(byte)];
}

- (void)addBytes:(Byte *)bytes withLength:(NSUInteger)length {
    for (int i = 0; i < length; i++) {
        NSNumber *number = @(bytes[i]);
        [self.inputDataBytes addObject:number];
    }
}


#pragma mark - Getting Data

- (NSData *)getRawData {
    return [self getRawDataWithEncryptionManager:nil];
}

- (NSData *)getRawDataWithEncryptionManager:(InputStickEncryptionManager *)encryptionManager {
    NSUInteger tmp = 6 + self.inputDataBytes.count; //crc (4B) + cmd (1B) + param (1B) + data length
    //add padding so that total length without header is divisible by 16
    NSUInteger lengthDiv16 = tmp / 16;
    if (lengthDiv16 * 16 < tmp) {
        lengthDiv16++;
    }
    NSUInteger packetLength = (lengthDiv16 * 16) + 2; //add 2B header

    NSMutableData *packetData = [NSMutableData dataWithLength:packetLength];
    Byte *packetBytes = (Byte *)packetData.bytes;

    //header
    packetBytes[0] = 0x55;
    packetBytes[1] = (Byte)lengthDiv16;
    if (self.requiresResponse) {
        packetBytes[1] |= 0x80;
    }
    //add CMD & PARAM
    packetBytes[6] = self.command;
    packetBytes[7] = self.param;
    //copy payload
    for (NSUInteger i = 0; i < self.inputDataBytes.count; ++i) {
        NSNumber *number = self.inputDataBytes[i];
        packetBytes[i + 8] = (Byte) [number integerValue];
    }
    //calculate & add CRC
    NSUInteger crcValue = [packetData crc32WithOffset:6 length:(packetLength - 6)]; //skip header and reserved CRC bytes
    packetBytes[5] = (Byte) crcValue;
    crcValue >>= 8;
    packetBytes[4] = (Byte) crcValue;
    crcValue >>= 8;
    packetBytes[3] = (Byte) crcValue;
    crcValue >>= 8;
    packetBytes[2] = (Byte) crcValue;
    //encrypt & add HMAC?
    if (encryptionManager != nil && [InputStickPacket canEncrypt:self.command]) {
        BOOL addHmac = [encryptionManager hmacEnabled];
        if (addHmac) {
            addHmac = [InputStickPacket requiresHMAC:self.command];
        }
        
        //update header
        packetBytes[1] |= 0x40;
        if (addHmac) {
            packetBytes[1] |= 0x20;
        }
        //encrypt data
        NSMutableData *encryptedPacket = [NSMutableData data];
        NSData *encryptedPayload = [encryptionManager encryptBytes:packetBytes + 2 withLength:(packetLength - 2)]; //do not encrypt header!
        //copy header & encrypted payload
        [encryptedPacket appendBytes:packetBytes length:2];
        [encryptedPacket appendData:encryptedPayload];
        //add HMAC to packet
        if (addHmac) {
            NSData *hmacData = [encryptionManager getHMACForData:encryptedPayload];
            [encryptedPacket appendData:hmacData];
        }
        return encryptedPacket;
    } else {
        return packetData;
    }
}


@end
