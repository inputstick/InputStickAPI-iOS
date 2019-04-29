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

@implementation InputStickDeviceData

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
    if (_firmwareVersion < InputStickLatestFirmwareVersion) {
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
    return (_firmwareVersion >= InputStickLatestFirmwareVersion);
}

- (NSString *)firmwareVersionString {
    float tmp = ((float)_firmwareVersion)/100;
    return [NSString stringWithFormat:@"v%.02f", tmp];
}


#pragma mark Device Capabilities


- (BOOL)supportsConfiguration {
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
