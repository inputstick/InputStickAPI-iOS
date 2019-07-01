/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickLog.h"
#import "InputStickPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickTxPacket.h"
#import "InputStickDeviceData.h"
#import "InputStickPreferences.h"
#import "InputStickKeyboardLayoutProtocol.h"


@implementation InputStickLog

+ (NSString *)hexStringFromData:(NSData *)data {
    #ifdef INPUTSTICK_LOG_PRINT_HEX_PREFIX
    NSUInteger capacity = data.length * 5;
    #else
    NSUInteger capacity = data.length * 3;
    #endif
    
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
    const unsigned char *dataBuffer = data.bytes;
    for (int i = 0; i < data.length; i++) {
        #ifdef INPUTSTICK_LOG_PRINT_HEX_PREFIX
        [stringBuffer appendFormat:@"0x%02lX ", (long)dataBuffer[i]];
        #else
        [stringBuffer appendFormat:@"%02lX ", (long)dataBuffer[i]];
        #endif
    }
    return [NSString stringWithString:stringBuffer];
}

+ (NSData *)dataFromHexString:(NSString *)hex {
    NSMutableData *data = [NSMutableData new];
    for (int i = 0; i < hex.length; i += 2) {
        char high = (char)[hex characterAtIndex:i];
        char low = (char)[hex characterAtIndex:i + 1];
        char bchars[3] = {high, low, '\0'};
        UInt8 byte = strtol(bchars, NULL, 16);
        [data appendBytes:&byte length:1];
    }
    return [NSData dataWithData:data];
}

+ (void)printHexNSData:(NSData *)data {
    NSString *s = [self hexStringFromData:data];
    NSLog(@"%@", s);
}

+ (void)printHexNSData:(NSData *)data withTitle:(NSString *)title {
    NSString *s = [self hexStringFromData:data];
    NSLog(@"%@: %@", title, s);
}

+ (void)printHexByte:(Byte)byte {
    #ifdef INPUTSTICK_LOG_PRINT_HEX_PREFIX
    NSLog(@"0x%02lX", (long)byte);
    #else
    NSLog(@"%02lX", (long)byte);
    #endif
}

+ (void)printHexByte:(Byte)byte  withTitle:(NSString *)title {
    #ifdef INPUTSTICK_LOG_PRINT_HEX_PREFIX
    NSLog(@"%@: 0x%02lX", title, (long)byte);
    #else
    NSLog(@"%@: %02lX", title, (long)byte);
    #endif
}

+ (void)printDeviceData:(InputStickDeviceData *)deviceData {
    NSLog(@"InputStick Device Data:");
    NSLog(@"Device name: %@", deviceData.name);
    NSLog(@"UUID: %@", deviceData.identifier);
    NSLog(@"FW version: %@", [deviceData firmwareVersionString]);
    if (deviceData.key == nil) {
        NSLog(@"No encryption key saved");
    } else {
        [self printHexNSData:deviceData.key withTitle:@"Encryption key"];
    }
    NSLog(@"");
}

+ (void)printPreferences:(InputStickPreferences *)preferences {
    NSLog(@"InputStick Preferences:");
    NSLog(@"Auto-connect: %d", preferences.autoConnect);
    
    NSLog(@"Keyboard layout: %@", [[preferences.keyboardLayout class] layoutCode]);
    NSLog(@"Typing speed: %ld", preferences.typingSpeed);
    
    if (preferences.touchScreenMode) {
        NSLog(@"Mousepad mode: touch-screen");
    } else {
        NSLog(@"Mousepad mode: mouse");
    }
    NSLog(@"Tap to click: %d", preferences.tapToClick);
    NSLog(@"Tap interval: %ld", preferences.tapInterval);
    NSLog(@"Mouse sensitivity: %ld", preferences.mouseSensitivity);
    NSLog(@"Scroll sensitivity: %ld", preferences.scrollSensitivity);
    NSLog(@"Mousepad ratio  (always 0 if in mouse mode): %f", preferences.mousepadRatio);
    NSLog(@"");
}

+ (void)printRxPacket:(InputStickRxPacket *)rxPacket {
    NSMutableData *packetData = [[NSMutableData alloc] init];
    unsigned char b[] = {rxPacket.command, rxPacket.respCode};
    if (rxPacket.isNotification) {
        NSLog(@"InputStick Rx Packet (Notification):");
        [self printHexByte:rxPacket.header];
        [packetData appendBytes:b length:1]; //cmd
        [packetData appendData:rxPacket.data];
        [self printHexNSData:packetData];
    } else {
        NSLog(@"InputStick Rx Packet (Response):");
        [self printHexByte:rxPacket.header];
        [packetData appendBytes:b length:2]; //cmd+respCode
        [packetData appendData:rxPacket.data];
        [self printHexNSData:packetData];
    }
    NSLog(@"");
}

+ (void)printTxPacket:(InputStickTxPacket *)txPacket {
    NSLog(@"InputStick Tx Packet:");
    NSMutableData *packetData = [txPacket getPacketData];
    NSUInteger length = [packetData length];
    [self printHexNSData:[packetData subdataWithRange:NSMakeRange(InputStickPacketCRC32Length, length - InputStickPacketCRC32Length)]];
    NSLog(@"");
}

@end
