/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickErrorDomain;


@interface InputStickError : NSObject

typedef NS_ENUM(NSUInteger, InputStickErrorCode) {
    INPUTSTICK_ERROR_NONE =                                0x0000,
    INPUTSTICK_ERROR_GENERAL =                             0x0001, //undefined error
    
    //Bluetooth:
    INPUTSTICK_ERROR_BT_GENERAL =                          0x0100, //undefined BT-related error
    INPUTSTICK_ERROR_BT_CONNECTION_LOST =                  0x0101, //BT connection lost
    INPUTSTICK_ERROR_BT_CONNECTION_TIMEDOUT =              0x0102, //device was discovered, but connection attempt failed
    INPUTSTICK_ERROR_BT_OUT_OF_RANGE =                     0x0103, //device not discovered (out of range or not plugged in)
    INPUTSTICK_ERROR_BT_NOT_SUPPORTED =                    0x0104, //BT not supported on this device
    INPUTSTICK_ERROR_BT_TURNED_OFF =                       0x0105, //BT turned off
    INPUTSTICK_ERROR_BT_INVALID_ADDRESS =                  0x0106, //invalid BT UUID
    INPUTSTICK_ERROR_BT_SERVICE =                          0x0107, //invalid/could not read service
    INPUTSTICK_ERROR_BT_CHARACTERISTIC =                   0x0108, //invalid/could not read characteristic
    INPUTSTICK_ERROR_BT_CHARACTERISTIC_VALUE =             0x0109, //invalid/could not read characteristic value
    INPUTSTICK_ERROR_BT_DESCRIPTOR =                       0x010A, //invalid/could not read descriptor
    
    //Hardware:
    INPUTSTICK_ERROR_HW_GENERAL =                          0x0200, //undefined InputStick hardware-related error
    INPUTSTICK_ERROR_HW_WATCHDOG_RESET =                   0x0201, //InputStick was reseted by internal watchdog
    
    //Firmware:
    INPUTSTICK_ERROR_FW_GENERAL =                          0x0300, //undefined InputStick firmware-related error
    INPUTSTICK_ERROR_FW_INIT_TIMEDOUT =                    0x0301, //failed to initialize complete firmware initialization process
    INPUTSTICK_ERROR_FW_USB_TIMEDOUT =                     0x0302, //failed to initialize USB (host is in sleep mode or did not enumerate InputStick)
    INPUTSTICK_ERROR_FW_UNSUPPORTED_VERSION =              0x0303, //firmware is not supported
    INPUTSTICK_ERROR_FW_UNSUPPORTED_CMD =                  0x0304, //received unsupported command
    INPUTSTICK_ERROR_FW_UNEXPECTED_VALUE =                 0x0305, //received unexpected value
    
    //Packet:
    INPUTSTICK_ERROR_PACKET_GENERAL =                      0x0400, //undefined packet-related error
    
    INPUTSTICK_ERROR_PACKET_RX_GENERAL =                   0x0410, //received packet: undefined error
    INPUTSTICK_ERROR_PACKET_RX_CRC =                       0x0411, //received packet: CRC check failed
    INPUTSTICK_ERROR_PACKET_RX_TAG =                       0x0412, //received packet: expected START_TAG
    INPUTSTICK_ERROR_PACKET_RX_HEADER =                    0x0413, //received packet: invalid header
    INPUTSTICK_ERROR_PACKET_RX_LENGTH =                    0x0414, //received packet: invalid length
    INPUTSTICK_ERROR_PACKET_RX_TIMEDOUT =                  0x0415, //received packet: timed out
    INPUTSTICK_ERROR_PACKET_RX_ENCR_NOT_ENABLED =          0x0416, //received packet: encryption not set up
    INPUTSTICK_ERROR_PACKET_RX_ENCR_MISSING =              0x0417, //received packet: expected encrypted packet
    INPUTSTICK_ERROR_PACKET_RX_HMAC =                      0x0418, //received packet: HMAC check failed
    INPUTSTICK_ERROR_PACKET_RX_HMAC_COUNTER =              0x0419, //received packet: HMAC counter out of sync
    INPUTSTICK_ERROR_PACKET_RX_HMAC_MISSING =              0x041A, //received packet: HMAC missing
    
    INPUTSTICK_ERROR_PACKET_TX_GENERAL =                   0x0420, //transmitted packet: undefined error
    INPUTSTICK_ERROR_PACKET_TX_CRC =                       0x0421, //transmitted packet: CRC check failed
    INPUTSTICK_ERROR_PACKET_TX_TAG =                       0x0422, //transmitted packet: expected START_TAG
    INPUTSTICK_ERROR_PACKET_TX_HEADER =                    0x0423, //transmitted packet: invalid header
    INPUTSTICK_ERROR_PACKET_TX_LENGTH =                    0x0424, //transmitted packet: invalid length
    INPUTSTICK_ERROR_PACKET_TX_TIMEDOUT =                  0x0425, //transmitted packet: timed out
    INPUTSTICK_ERROR_PACKET_TX_ENCR_NOT_ENABLED =          0x0426, //transmitted packet: encryption not set up
    INPUTSTICK_ERROR_PACKET_TX_ENCR_MISSING =              0x0427, //transmitted packet: expected encrypted packet
    INPUTSTICK_ERROR_PACKET_TX_HMAC =                      0x0428, //transmitted packet: HMAC check failed
    INPUTSTICK_ERROR_PACKET_TX_HMAC_COUNTER =              0x0429, //transmitted packet: HMAC counter out of sync
    INPUTSTICK_ERROR_PACKET_TX_HMAC_MISSING =              0x042A, //transmitted packet: HMAC missing
    
    //Encryption:
    INPUTSTICK_ERROR_ENCRYPTION_GENERAL =                  0x0500, //undefined InputStick encryption-related error
    INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_APP =        0x0501, //encryption is not supported by this application (was disabled in InputStickEncryptionManager
    INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_DEVICE =     0x0502, //encryption is not supported by InputStick firmware or it uses different encryption protocol
    INPUTSTICK_ERROR_ENCRYPTION_NO_KEY =                   0x0503, //has no saved key but InputStick is password protected
    INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY =              0x0504, //invalid encryption key (InputStick password was changed)
    INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED =              0x0505, //has saved encryption key but InputStick is no longer password protected
    INPUTSTICK_ERROR_ENCRYPTION_VERIFICATION_FAILED =      0x0506, //failed to verify encryption key
    INPUTSTICK_ERROR_ENCRYPTION_NOT_ENABLED =              0x0507, //received encrypted packet but encryption was not enabled by API
    
    //iOS/App:
    INPUTSTICK_ERROR_IOS_GENERAL =                         0x0700, //undefined iOS-related error
    INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED =               0x0701, //BT UUID or most recently used device is required but there are no saved UUIDs
    INPUTSTICK_ERROR_IOS_MOST_RECENT_DEVICE_REMOVED =      0x0702, //most recently used InputStick was removed from database
    INPUTSTICK_ERROR_IOS_NO_DELEGATE =                     0x0703, //InputStick delegate not set; can't display dialog    
};


+ (NSError *)getNSErrorWithCode:(InputStickErrorCode)code;

@end
