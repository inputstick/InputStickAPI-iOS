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
    InputStickPacketParsingState _parsingState;    //current parsing state
    NSUInteger _position;           //current length of response
    NSUInteger _expectedLength;             //expected length of response
    Byte _header;                           //packet header
    NSMutableData *_packetData;           //response data buffer
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
    _parsingState = InputStickPacketParsingStateTag;
    _errorCode = INPUTSTICK_ERROR_NONE;
    _parsedPacket = nil;
}

- (InputStickPacketParsingResult)parseResponseByte:(Byte)responseByte {
    InputStickPacketParsingResult result = InputStickPacketParsingResultInProgress;
    switch (_parsingState) {
        case InputStickPacketParsingStateTag:
            if (responseByte == 0x55) {
                _parsingState = InputStickPacketParsingStateHeader;
                _packetData = nil;
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
            _expectedLength = (NSUInteger) (responseByte & 0x3F);
            _expectedLength *= 16;
            _position = 0;
            _packetData = [NSMutableData dataWithLength:_expectedLength];
            _parsingState = InputStickPacketParsingStatePayload;
            break;
        case InputStickPacketParsingStatePayload:
            if (_position < _expectedLength) {
                ((Byte *)_packetData.bytes)[_position] = responseByte;
                _position++;
                if (_position == _expectedLength) {
                    if ([self preparePacket]) {
                        _parsingState = InputStickPacketParsingStateTag;
                        result = InputStickPacketParsingResultDone;
                    } else {
                        _parsingState = InputStickPacketParsingStateDisabled;
                        result = InputStickPacketParsingResultError;
                    }
                }
            } else {
                _parsingState = InputStickPacketParsingStateTag;
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
    NSData *packetData = _packetData;
    
    if ((_header & InputStickPacketFlagEncrypted) != 0) {
        if (_manager.encryptionEnabled) {
            packetData = [_manager.encryptionManager decryptData:packetData];
        } else {
            _errorCode = INPUTSTICK_ERROR_PACKET_RX_ENCR_NOT_ENABLED;
            return FALSE;
        }
    }
    
    _parsedPacket = [[InputStickRxPacket alloc] initWithData:packetData header:_header];
    if ( !_parsedPacket.crc32Check) {
        _parsedPacket = nil;
        _errorCode = INPUTSTICK_ERROR_PACKET_RX_CRC;
        return FALSE;
    }
    return TRUE;
}



@end
