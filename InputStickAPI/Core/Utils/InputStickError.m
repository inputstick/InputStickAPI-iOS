/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickError.h"
#import "InputStickConst.h"

NSString *const InputStickErrorDomain = @"InputStickErrorDomain";


@implementation InputStickError

+ (NSError *)getNSErrorWithCode:(InputStickErrorCode)code {
    NSString *localizedDescriptionText = nil;
    
    switch (code) {
        //special case: no error
        case INPUTSTICK_ERROR_NONE:
            return nil;
        case INPUTSTICK_ERROR_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_GENERAL", InputStickStringTable, nil);
            break;
            
        //Bluetooth:
        case INPUTSTICK_ERROR_BT_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_CONNECTION_LOST:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_CONNECTION_LOST", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_CONNECTION_TIMEDOUT:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_CONNECTION_TIMEDOUT", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_OUT_OF_RANGE:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_OUT_OF_RANGE", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_NOT_SUPPORTED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_NOT_SUPPORTED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_TURNED_OFF:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_TURNED_OFF", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_INVALID_ADDRESS:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_INVALID_ADDRESS", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_SERVICE:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_SERVICE", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_CHARACTERISTIC:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_CHARACTERISTIC", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_CHARACTERISTIC_VALUE:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_CHARACTERISTIC_VALUE", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_BT_DESCRIPTOR:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_BT_DESCRIPTOR", InputStickStringTable, nil);
            break;
            
        //Hardware:
        case INPUTSTICK_ERROR_HW_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_HW_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_HW_WATCHDOG_RESET:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_HW_WATCHDOG_RESET", InputStickStringTable, nil);
            break;
            
        //Firmware:
        case INPUTSTICK_ERROR_FW_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_FW_INIT_TIMEDOUT:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_INIT_TIMEDOUT", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_FW_USB_TIMEDOUT:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_USB_TIMEDOUT", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_FW_UNSUPPORTED_VERSION:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_UNSUPPORTED_VERSION", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_FW_UNSUPPORTED_CMD:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_UNSUPPORTED_CMD", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_FW_UNEXPECTED_VALUE:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_FW_UNEXPECTED_VALUE", InputStickStringTable, nil);
            break;
            
        //Packet:
        case INPUTSTICK_ERROR_PACKET_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_GENERAL", InputStickStringTable, nil);
            break;
            
        case INPUTSTICK_ERROR_PACKET_RX_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_CRC:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_CRC", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_TAG:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_TAG", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_HEADER:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_HEADER", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_LENGTH:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_LENGTH", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_TIMEDOUT:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_TIMEDOUT", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_ENCR_NOT_ENABLED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_ENCR_NOT_ENABLED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_ENCR_MISSING:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_ENCR_MISSING", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_HMAC:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_HMAC", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_HMAC_COUNTER:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_HMAC_COUNTER", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_RX_HMAC_MISSING:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_RX_HMAC_MISSING", InputStickStringTable, nil);
            break;
            
        case INPUTSTICK_ERROR_PACKET_TX_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_CRC:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_CRC", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_TAG:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_TAG", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_HEADER:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_HEADER", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_LENGTH:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_LENGTH", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_TIMEDOUT:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_TIMEDOUT", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_ENCR_NOT_ENABLED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_ENCR_NOT_ENABLED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_ENCR_MISSING:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_ENCR_MISSING", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_HMAC:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_HMAC", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_HMAC_COUNTER:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_HMAC_COUNTER", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_PACKET_TX_HMAC_MISSING:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_PACKET_TX_HMAC_MISSING", InputStickStringTable, nil);
            break;
            
        //Encryption:
        case INPUTSTICK_ERROR_ENCRYPTION_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_APP:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_APP", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_DEVICE:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_NOT_SUPPORTED_DEVICE", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_NO_KEY:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_NO_KEY", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_VERIFICATION_FAILED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_VERIFICATION_FAILED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_ENCRYPTION_NOT_ENABLED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_ENCRYPTION_NOT_ENABLED", InputStickStringTable, nil);
            break;
            
        //iOS/App:
        case INPUTSTICK_ERROR_IOS_GENERAL:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_IOS_GENERAL", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED", InputStickStringTable, nil);
            break;
        case INPUTSTICK_ERROR_IOS_MOST_RECENT_DEVICE_REMOVED:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_IOS_MOST_RECENT_DEVICE_REMOVED", InputStickStringTable, nil);
            break;
            
        default:
            localizedDescriptionText = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_UNKNOWN", InputStickStringTable, nil);
    }
    
    NSError *error = [[NSError alloc] initWithDomain:InputStickErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:localizedDescriptionText}];
    return error;
}

@end
