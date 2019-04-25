/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPacketFactory.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickEncryptionManager.h"
#import "InputStickPacket.h"
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


@end
