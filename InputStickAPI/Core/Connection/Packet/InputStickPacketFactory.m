/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPacketFactory.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickEncryptionManager.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickError.h"
#import "NSData+CRC.h"


@interface InputStickPacketFactory () {
    InputStickManager *_manager;
    //rx:
    InputStickResponseParsingState _responseParsingState;    //current parsing state
    NSUInteger _responsePosition;           //current length of response
    NSUInteger _responseLength;             //expected length of response
    Byte _header;                           //packet header
    NSMutableData *_responseData;           //response data buffer
    NSUInteger _rxWdgCnt;                   //watchdog reset event counter
    BOOL _wdgPacket;                        //indicates possbile watchdog reset
}

@end


@implementation InputStickPacketFactory


- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
    }
    return self;
}


#pragma mark - RX Packet

- (void)resetRxState {
    _responseParsingState = InputStickResponseParsingStateTag;
    _errorCode = INPUTSTICK_ERROR_NONE;
    _parsedPacket = nil;
}

- (InputStickPacketParsingResult)parseResponseByte:(Byte)responseByte {
    InputStickPacketParsingResult result = InputStickPacketParsingInProgress;
    switch (_responseParsingState) {
        case InputStickResponseParsingStateTag:
            if (responseByte == 0x55) {
                _responseParsingState = InputStickResponseParsingStateHeader;
                _responseData = nil;
                _wdgPacket = FALSE;
                result = InputStickPacketParsingStarted;
            } else {
                if (responseByte == 0xAF) {
                    _rxWdgCnt++;
                }
                if (_rxWdgCnt > 256 && !_wdgPacket) {
                    _rxWdgCnt = 0;
                    _wdgPacket = TRUE;
                    unsigned char b[] = {0x00, 0x00, 0x00, 0x00, CmdWdgReset, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
                    _parsedPacket = [[InputStickRxPacket alloc] initWithRawData:[NSData dataWithBytes:b length:16] header:0x01];
                    result = InputStickPacketParsingDone;
                }
            }
            break;
        case InputStickResponseParsingStateHeader:
            _header = responseByte;
            _responseLength = (NSUInteger) (responseByte & 0x3F);
            _responseLength *= 16;
            _responsePosition = 0;          
            _responseData = [NSMutableData dataWithLength:_responseLength];
            _responseParsingState = InputStickResponseParsingStateData;
            break;
        case InputStickResponseParsingStateData:
            if (_responsePosition < _responseLength) {
                ((Byte *)_responseData.bytes)[_responsePosition] = responseByte;
                _responsePosition++;
                if (_responsePosition == _responseLength) {
                    _parsedPacket = [[InputStickRxPacket alloc] initWithRawData:_responseData header:_header];
                    _responseParsingState = InputStickResponseParsingStateTag;
                    result = InputStickPacketParsingDone;
                }
            } else {
                _responseParsingState = InputStickResponseParsingStateTag;
                _errorCode = INPUTSTICK_ERROR_PACKET_RX_LENGTH;
                result = InputStickPacketParsingError;
            }
            break;
    }
    return result;
}

- (BOOL)verifyPacket:(InputStickRxPacket *)rxPacket inputStickManager:(InputStickManager *)inputStickManager {
    BOOL result = FALSE;
    if (rxPacket.encrypted) {
        if (inputStickManager.encryptionEnabled) {
            [rxPacket decryptWithEncryptionManager:inputStickManager.encryptionManager];
        } else {
            _errorCode = INPUTSTICK_ERROR_ENCRYPTION_NOT_ENABLED;
        }
    }
    if (rxPacket.crc32CheckPassed) {
        result = TRUE;
    } else {
        _errorCode = INPUTSTICK_ERROR_PACKET_RX_CRC;
    }
    return result;
}


#pragma mark - TX Packet

- (InputStickTxPacket *)prepareRunFirmwarePacket {
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdRunFirmware];
    packet.requiresResponse = YES;
    return packet;
}

- (InputStickTxPacket *)prepareGetFirmwareInfoPacket {
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdGetFirmwareInfo];
    packet.requiresResponse = YES;
    return packet;
}

- (InputStickTxPacket *)prepareSetUpdateIntervalPacketWithParam:(Byte)param {
    InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:CmdSetUpdateInterval withParam:param];
    packet.requiresResponse = NO;
    return packet;
}


#pragma mark - Authentication Packet

- (InputStickTxPacket *)prepareAuthenticatePacket:(BOOL)hmacEnabledDevice {
    InputStickTxPacket *packet;
    if (hmacEnabledDevice) {
        packet = [[InputStickTxPacket alloc] initWithCmd:CmdAuthenticateHMAC withParam:0x00];
    } else {
        packet = [[InputStickTxPacket alloc] initWithCmd:CmdAuthenticate withParam:0x00];
    }
    packet.requiresResponse = YES;
    
    Byte *bytesArray;

    //add IV to packet
    [packet addBytes:(Byte *)_manager.encryptionManager.iv.bytes withLength:16];
    //PROVE THAT WE KNOW THE KEY:
    //generate random data:
    NSData *randomData = [InputStickEncryptionManager randomDataWithLength:16];
    
    //calculate CRC; use only bytes 4 through 16
    NSUInteger crcValue = [randomData crc32WithOffset:4 length:(NSUInteger)(12)];
    //store CRC value as first 4 bytes
    bytesArray = (Byte *)randomData.bytes;
    bytesArray[3] = (Byte)crcValue;
    crcValue >>= 8;
    bytesArray[2] = (Byte)crcValue;
    crcValue >>= 8;
    bytesArray[1] = (Byte)crcValue;
    crcValue >>= 8;
    bytesArray[0] = (Byte)crcValue;

    //encrypt
    NSData *encryptedRandomData = [_manager.encryptionManager encryptData:randomData];
    //add to packet
    [packet addBytes:(Byte *)encryptedRandomData.bytes withLength:16];
    //request proof that remote device shares the same encryption key
    //generate & add challenge data
    NSData *tmp = [_manager.encryptionManager prepareChallengeData];
    [packet addBytes:(Byte *)tmp.bytes withLength:16];
    return packet;
}

- (BOOL)verifyAuthenticationResponsePacket:(InputStickRxPacket *)rxPacket {
    BOOL verificationResult;
    NSData *tmp = [NSData dataWithBytes:(rxPacket.bytes + 2) length:16];
    verificationResult = [_manager.encryptionManager verifyChallengeResponse:tmp];
    
    if ((rxPacket.command == CmdAuthenticateHMAC) && (verificationResult)) {
        NSData *encryptedKey = [NSData dataWithBytes:(rxPacket.bytes + 18) length:32];
        NSData *hmacKey = [_manager.encryptionManager decryptData:encryptedKey];
        [_manager.encryptionManager initHMACWithKey:hmacKey]; 
    }
    return verificationResult;
}


@end
