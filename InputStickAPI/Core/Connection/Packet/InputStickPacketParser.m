/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPacketParser.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickEncryptionManager.h"
#import "InputStickPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickError.h"
#import "NSData+CRC.h"


@interface InputStickPacketParser () {
    InputStickManager *_manager;
    //rx:
    InputStickPacketParsingState _responseParsingState;    //current parsing state
    NSUInteger _responsePosition;           //current length of response
    NSUInteger _responseLength;             //expected length of response
    Byte _header;                           //packet header
    NSMutableData *_responseData;           //response data buffer
    NSUInteger _rxWdgCnt;                   //watchdog reset event counter
    BOOL _wdgPacket;                        //indicates possbile watchdog reset
}

@end


@implementation InputStickPacketParser


- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
    }
    return self;
}


#pragma mark - RX Packet

- (void)resetRxState {
    _responseParsingState = InputStickPacketParsingStateTag;
    _errorCode = INPUTSTICK_ERROR_NONE;
    _parsedPacket = nil;
}

- (InputStickPacketParsingResult)parseResponseByte:(Byte)responseByte {
    InputStickPacketParsingResult result = InputStickPacketParsingResultInProgress;
    switch (_responseParsingState) {
        case InputStickPacketParsingStateTag:
            if (responseByte == 0x55) {
                _responseParsingState = InputStickPacketParsingStateHeader;
                _responseData = nil;
                _wdgPacket = FALSE;
                result = InputStickPacketParsingResultStarted;
            } else {
                if (responseByte == 0xAF) {
                    _rxWdgCnt++;
                }
                if (_rxWdgCnt > 256 && !_wdgPacket) {
                    _rxWdgCnt = 0;
                    _wdgPacket = TRUE;
                    unsigned char b[] = {CmdWdgReset, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
                    _parsedPacket = [[InputStickRxPacket alloc] initWithData:[NSData dataWithBytes:b length:12] header:0x01];
                    result = InputStickPacketParsingResultDone;
                }
            }
            break;
        case InputStickPacketParsingStateHeader:
            _header = responseByte;
            _responseLength = (NSUInteger) (responseByte & 0x3F);
            _responseLength *= 16;
            _responsePosition = 0;          
            _responseData = [NSMutableData dataWithLength:_responseLength];
            _responseParsingState = InputStickPacketParsingStatePayload;
            break;
        case InputStickPacketParsingStatePayload:
            if (_responsePosition < _responseLength) {
                ((Byte *)_responseData.bytes)[_responsePosition] = responseByte;
                _responsePosition++;
                if (_responsePosition == _responseLength) {
                    if ([self preparePacket]) {
                        _responseParsingState = InputStickPacketParsingStateTag;
                        result = InputStickPacketParsingResultDone;
                    } else {
                        _responseParsingState = InputStickPacketParsingStateDisabled;
                        result = InputStickPacketParsingResultError;
                    }
                }
            } else {
                _responseParsingState = InputStickPacketParsingStateTag;
                _errorCode = INPUTSTICK_ERROR_PACKET_RX_LENGTH;
                result = InputStickPacketParsingResultError;
            }
            break;
        case InputStickPacketParsingStateDisabled:
            result = InputStickPacketParsingResultInProgress;
            break;
    }
    return result;
}


#pragma mark - Helpers

- (BOOL)preparePacket {
    NSUInteger crcValue, crcCompare;
    NSData *payload = _responseData;
    
    if ((_header & InputStickPacketFlagEncrypted) != 0) {
        if (_manager.encryptionEnabled) {
            payload = [_manager.encryptionManager decryptData:_responseData];
        } else {
            _errorCode = INPUTSTICK_ERROR_PACKET_RX_ENCR_NOT_ENABLED;
            return FALSE;
        }
    }
    
    Byte *bytes = ((Byte *)payload.bytes);
    crcCompare = 0;
    crcCompare += bytes[0];
    crcCompare <<= 8;
    crcCompare += bytes[1];
    crcCompare <<= 8;
    crcCompare += bytes[2];
    crcCompare <<= 8;
    crcCompare += bytes[3];
    if (crcCompare != 0) {
        crcValue = [payload crc32WithOffset:4 length:([payload length] - 4)];
        if (crcValue != crcCompare) {
            _errorCode = INPUTSTICK_ERROR_PACKET_RX_CRC;
            return FALSE;
        }
    }
    
    payload = [payload subdataWithRange:NSMakeRange(4, [payload length] - 4)]; //remove CRC
    _parsedPacket = [[InputStickRxPacket alloc] initWithData:payload header:_header];
    return TRUE;
}



@end
