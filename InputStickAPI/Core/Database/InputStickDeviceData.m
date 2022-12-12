/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickDeviceData.h"
#import "InputStickManager.h"
#import "InputStickDeviceDB.h"
#import "InputStickRxPacket.h"
#import "InputStickRxPacket+FirmwareInfo.h"
#import "InputStickConst.h"
#import "InputStickDataUtils.h"

@implementation InputStickDeviceData

- (instancetype)initWithNSData:(NSData *)data {
    self = [super init];
    if (self) {
        BOOL read = TRUE;
        NSUInteger location = 0;
        Byte tag = 0;
        
        while(read) {
            tag = [InputStickDataUtils readByteFromData:data atLocation:&location];
            switch (tag) {
                case InputStickDeviceDataTagEnd:
                    read = FALSE;
                    break;
                case InputStickDeviceDataTagName:
                    _name = [InputStickDataUtils readStringFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagIdentifier:
                    _identifier = [InputStickDataUtils readStringFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagKey:
                    _key = [InputStickDataUtils readDataFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagPlainText:
                    _plainText = [InputStickDataUtils readStringFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagPasswordProtectionStatus:
                    _passwordProtectionStatus = [InputStickDataUtils readUIntFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagFirmwareVersion:
                    _firmwareVersion = [InputStickDataUtils readUIntFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagNextAllowedFirmwareUpdateReminder:
                    _nextAllowedFirmwareUpdateReminder = [InputStickDataUtils readUIntFromData:data atLocation:&location];
                    break;
                case InputStickDeviceDataTagFirmwareUpdateReminderVersion:
                    _firmwareUpdateReminderVersion = [InputStickDataUtils readUIntFromData:data atLocation:&location];
                    break;
                default:
                    read = FALSE;
                    break;
            }
        }
    }
    return self;
}

- (instancetype)initWithDeviceDB:(InputStickDeviceDB *)db withIdentifier:(NSString *)identifier withName:(NSString *)name {
    self = [super init];
    if (self) {
        _db = db;
        _identifier = identifier;
        _name = name;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)coder {
    if ((self = [super init])) {
        _name = [coder decodeObjectForKey:@"name"];
        _identifier = [coder decodeObjectForKey:@"identifier"];
        _key = [coder decodeObjectForKey:@"key"];
        _plainText = [coder decodeObjectForKey:@"plainText"];
        _passwordProtectionStatus = [coder decodeIntegerForKey:@"passwordProtectionStatus"];
        _firmwareVersion = [coder decodeIntegerForKey:@"firmwareVersion"];
        _nextAllowedFirmwareUpdateReminder = [coder decodeIntegerForKey:@"nextAllowedFirmwareUpdateReminder"];
        _firmwareUpdateReminderVersion = [coder decodeIntegerForKey:@"_firmwareUpdateReminderVersion"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_identifier forKey:@"identifier"];
    [coder encodeObject:_key forKey:@"key"];
    [coder encodeObject:_plainText forKey:@"plainText"];
    [coder encodeInteger:_passwordProtectionStatus forKey:@"passwordProtectionStatus"];
    [coder encodeInteger:_firmwareVersion forKey:@"firmwareVersion"];
    [coder encodeInteger:_nextAllowedFirmwareUpdateReminder forKey:@"nextAllowedFirmwareUpdateReminder"];
    [coder encodeInteger:_firmwareUpdateReminderVersion forKey:@"_firmwareUpdateReminderVersion"];
}

- (NSData *)getData {
    NSMutableData *data = [[NSMutableData alloc] init];
    //name:
    [InputStickDataUtils addByte:InputStickDeviceDataTagName toData:data];
    [InputStickDataUtils addString:_name toData:data];
    //identifier:
    [InputStickDataUtils addByte:InputStickDeviceDataTagIdentifier toData:data];
    [InputStickDataUtils addString:_identifier toData:data];
    //key:
    [InputStickDataUtils addByte:InputStickDeviceDataTagKey toData:data];
    [InputStickDataUtils addData:_key toData:data];
    //_plainText:
    [InputStickDataUtils addByte:InputStickDeviceDataTagPlainText toData:data];
    [InputStickDataUtils addString:_plainText toData:data];
    //passwordProtectionStatus:
    [InputStickDataUtils addByte:InputStickDeviceDataTagPasswordProtectionStatus toData:data];
    [InputStickDataUtils addUInt:_passwordProtectionStatus toData:data];
    //firmwareVersion:
    [InputStickDataUtils addByte:InputStickDeviceDataTagFirmwareVersion toData:data];
    [InputStickDataUtils addUInt:_firmwareVersion toData:data];
    //nextAllowedFirmwareUpdateReminder:
    [InputStickDataUtils addByte:InputStickDeviceDataTagNextAllowedFirmwareUpdateReminder toData:data];
    [InputStickDataUtils addUInt:_nextAllowedFirmwareUpdateReminder toData:data];
    //firmwareUpdateReminderVersion:
    [InputStickDataUtils addByte:InputStickDeviceDataTagFirmwareUpdateReminderVersion toData:data];
    [InputStickDataUtils addUInt:_firmwareUpdateReminderVersion toData:data];
    //end tag
    [InputStickDataUtils addByte:InputStickDeviceDataTagEnd toData:data];
    return data;
}

- (void)updateDeviceInfoWithPacket:(InputStickRxPacket *)rxPacket {
    if (_firmwareVersion != rxPacket.firmwareVersion) {
        _firmwareVersion = rxPacket.firmwareVersion;
        [self.db storeDatabase];
    }
    [self.db setMostRecentlyUsedDeviceIdentifierTo:self.identifier];
}

- (void)setName:(NSString *)name {
    if (_name == nil && name == nil) {
        return;
    }
    if ([_name isEqualToString:name]) {
        return;
    }
    
    _name = name;
    [self.db storeDatabase];
}

- (void)setKey:(NSData *)key {
    if (_key == nil && key == nil) {
        return;
    }
    if ([_key isEqualToData:key]) {
        return;
    }

    _key = key;
    if (key == nil) {
        _plainText = nil;
    }
    [self.db storeDatabase];
}

- (void)setPlainText:(NSString *)plainText {
    if (_plainText == nil && plainText == nil) {
        return;
    }
    if ([_plainText isEqualToString:plainText]) {
        return;
    }
    
    _plainText = plainText;
    [self.db storeDatabase];
}

- (void)setPasswordProtectionStatus:(InputStickPasswordProtectionStatus)passwordProtectionStatus {
    if (passwordProtectionStatus != _passwordProtectionStatus) {
        _passwordProtectionStatus = passwordProtectionStatus;
        [self.db storeDatabase];
    }
}

- (BOOL)hasPasswordProtectionIssue {
    return !((_passwordProtectionStatus == PasswordProtectionDisabledOK) || (_passwordProtectionStatus == PasswordProtectionEnabledOK));
}


#pragma mark Firmware Update

- (void)postponeFirmwareUpdateReminderBy:(NSUInteger)seconds {
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    _nextAllowedFirmwareUpdateReminder = timeInSeconds + seconds;
    [self.db storeDatabase];
}

- (void)disableFirmwareUpdateReminder {
    _nextAllowedFirmwareUpdateReminder = 1;
    [self.db storeDatabase];
}

- (BOOL)shouldDisplayFirmwareUpdateMessage {
    if (_firmwareVersion < InputStickFirmwareVersionMinRecommended) {
        //if there's even newer version available than before (when user decided to postpone/disable reminder), reset reminder settings (in case it was disabled)
        if (_firmwareUpdateReminderVersion < InputStickFirmwareVersionLatest) {
            _firmwareUpdateReminderVersion = InputStickFirmwareVersionLatest;
            _nextAllowedFirmwareUpdateReminder = 0;
            [self.db storeDatabase];
            return TRUE;
        }
        switch (_nextAllowedFirmwareUpdateReminder) {
            case 0:
                return TRUE;
            case 1:
                return FALSE;
            default:
                return ([[NSDate date] timeIntervalSince1970] > _nextAllowedFirmwareUpdateReminder);
        }
    } else {
        return FALSE;
    }
}

- (BOOL)hasLatestFirmware {
    return (_firmwareVersion >= InputStickFirmwareVersionLatest);
}

- (NSString *)firmwareVersionString {
    if (_firmwareVersion == 0) {
        return @"???";
    } else {
        float tmp = ((float)_firmwareVersion)/100;
        return [NSString stringWithFormat:@"v%.02f", tmp];
    }
}


#pragma mark Device Capabilities


- (BOOL)supportsUSBConfiguration {
    if (_firmwareVersion == 111) {
        return FALSE;
    }
    return (_firmwareVersion >= 99);
}

- (BOOL)supportsBTConfiguration {
    return (_firmwareVersion >= 99);
}

- (BOOL)supportsCustomUpdateNotificationInterval {
    return (_firmwareVersion >= 100);
}

- (BOOL)supportsHMAC {
    return (_firmwareVersion >= 100);
}

- (BOOL)supportsKeygen {
    return (_firmwareVersion >= 101);
}

@end
