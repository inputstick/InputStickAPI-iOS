/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickManager.h"
#import "InputStickConst.h"
#import "InputStickDataUtils.h"


@implementation InputStickDeviceDB

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager {
    if ((self = [super init])) {
        _inputStickManager = inputStickManager;
        [self loadDatabase];
    }
    return self;
}

- (void)loadDatabase {
    [NSKeyedUnarchiver setClass:[InputStickDeviceData class] forClassName:InputStickDatabaseClassName]; //required to maintain compatibility after renaming ISDeviceData to InputStickDeviceData
    NSData *data = [_inputStickManager.userDefaults objectForKey:InputStickDatabaseKey];
    _deviceDbArray = nil;
    
    if (data != nil) {
        //check database format: custom NSData (new) or NSKeyedUnarchiver (old)
        BOOL newDatabaseFormat = FALSE;
        NSUInteger location = 0;
        if ([data length] >= 8) {
            NSUInteger magicNumber = [InputStickDataUtils readUIntFromData:data atLocation:&location];
            if (magicNumber == InputStickDatabaseMagicNumber) { //check for magic number indicating new database format
                newDatabaseFormat = TRUE;
            }
        }
        //read:
        @try {
            if (newDatabaseFormat) {
                _deviceDbArray = [[NSMutableArray alloc] init];
                BOOL read = TRUE;
                while (read) {
                    Byte tag = [InputStickDataUtils readByteFromData:data atLocation:&location];
                    if (tag == InputStickDeviceDataTagDeviceData) {
                        NSData *tmpData = [InputStickDataUtils readDataFromData:data atLocation:&location];
                        InputStickDeviceData *tmpDev = [[InputStickDeviceData alloc] initWithNSData:tmpData];
                        [_deviceDbArray addObject:tmpDev];
                    } else {
                        read = FALSE;
                    }
                }
            } else {
                //NSArray<InputStickDeviceData *> *tmpArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                NSError* error;
                NSArray<InputStickDeviceData *> *tmpArray;
                tmpArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:data error:&error];
                _deviceDbArray = [tmpArray mutableCopy];
                [self storeDatabase]; //will save database using new format
            }
        }
        @catch (NSException *exception) {
            //_deviceDbArray == nil -> empty database will be stored, overwriting corrupted data
        }
    }
    
    if (_deviceDbArray == nil) {
        _deviceDbArray = [[NSMutableArray alloc] init];
        [self storeDatabase]; //will save database using new format
    }
    
    for (int i = 0; i < [_deviceDbArray count]; i++) {
        InputStickDeviceData *tmpDev = [_deviceDbArray objectAtIndex:i];
        tmpDev.db = self;
    }
}

- (void)storeDatabase {
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_deviceDbArray];
    
    //new database format:
    NSMutableData *data = [[NSMutableData alloc] init];
    [InputStickDataUtils addUInt:InputStickDatabaseMagicNumber toData:data]; //add magic number indicating new database format
    for (int i = 0; i < [_deviceDbArray count]; i++) {
        InputStickDeviceData *tmpDev = [_deviceDbArray objectAtIndex:i];
        NSData *tmpData = [tmpDev getData];
        [InputStickDataUtils addByte:InputStickDeviceDataTagDeviceData toData:data];
        [InputStickDataUtils addData:tmpData toData:data];
    }
    //end tag:
    [InputStickDataUtils addByte:InputStickDeviceDataTagEnd toData:data];
    
    [_inputStickManager.userDefaults setObject:data forKey:InputStickDatabaseKey];
    [_inputStickManager.userDefaults synchronize];
}

- (BOOL)hasDeviceWithIdentifier:(NSString *)identifier {
    if (identifier == nil) {
        return FALSE;
    }
    
    InputStickDeviceData *tmp;
    for (int i = 0; i < [_deviceDbArray count]; i++) {
        tmp = [_deviceDbArray objectAtIndex:i];
        if ([tmp.identifier isEqual:identifier]) {
            return TRUE;
        }
    }
    return FALSE;
}

- (InputStickDeviceData *)getDataForDeviceWithIdentifier:(NSString *)identifier {
    if (identifier == nil) {
        return nil;
    }
    
    InputStickDeviceData *tmp;
    for (int i = 0; i < [_deviceDbArray count]; i++) {
        tmp = [_deviceDbArray objectAtIndex:i];
        if ([tmp.identifier isEqual:identifier]) {
            return tmp;
        }
    }
    return nil;
}

- (BOOL)createDeviceWithIdentifier:(NSString *)identifier withPreferredName:(NSString *)preferredName {
    if ( ![self hasDeviceWithIdentifier:identifier]) {
        InputStickDeviceData *tmp;
        tmp = [[InputStickDeviceData alloc] initWithDeviceDB:self withIdentifier:identifier withName:[self getNextAvailableName:preferredName]];
        [_deviceDbArray addObject:tmp];
        [self storeDatabase];
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)deleteDeviceWithIndex:(NSUInteger)index {
    [_deviceDbArray removeObjectAtIndex:index];
    [self storeDatabase];
}

- (void)deleteDeviceWithIdentifier:(NSString *)identifier {
    NSString *predicate = [NSString stringWithFormat:@"identifier ==[c] '%@'", identifier];
    NSArray<InputStickDeviceData *> *tmp = [_deviceDbArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:predicate]];
    [_deviceDbArray removeObjectsInArray:tmp];
    [self storeDatabase];
}

- (void)swapDeviceFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex updateDatabase:(BOOL)update {
    InputStickDeviceData *tmp = [_deviceDbArray objectAtIndex:fromIndex];
    [_deviceDbArray removeObjectAtIndex:fromIndex];
    [_deviceDbArray insertObject:tmp atIndex:toIndex];
    if (update) {
        [self storeDatabase];
    }
}

- (NSUInteger)numberOfStoredDevices {
    return [_deviceDbArray count];
}

#pragma mark - Most recently used InputStick

- (NSString *)getMostRecentlyUsedDeviceIdentifier {
    NSString *tmp = [_inputStickManager.userDefaults objectForKey:InputStickMostRecentDeviceKey];
    if (tmp != nil) {
        //check if the device is still in DB
        for (InputStickDeviceData *devData in _deviceDbArray) {
            if ([tmp isEqualToString:devData.identifier]) {
                return tmp;
            }
        }
    }
    return nil;
}

- (void)setMostRecentlyUsedDeviceIdentifierTo:(NSString *)identifier {
    [_inputStickManager.userDefaults setObject:identifier forKey:InputStickMostRecentDeviceKey];
    [_inputStickManager.userDefaults synchronize];
}


#pragma mark - Name helpers

- (BOOL)canUseName:(NSString *)name {
    for (InputStickDeviceData *devData in _deviceDbArray) {
        if ([name isEqualToString:devData.name]) {
            return FALSE;
        }
    }
    return TRUE;
}

- (NSString *)getNextAvailableName:(NSString *)preferredName {
    NSString *name;
    NSUInteger cnt = 0;
    if ([self canUseName:preferredName]) {
        return preferredName;
    } else {
        while (cnt < 1000) {
            name = [NSString stringWithFormat:@"%@-%ld", preferredName, (unsigned long)cnt];
            if ([self canUseName:name]) {
                return name;
            }
            cnt++;
        }
        //failsafe:
        return InputStickDatabaseDefaultDeviceName;
    }
}

@end
