/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickConst.h"


@implementation InputStickDeviceDB

- (instancetype)init {
    if ((self = [super init])) {
        [self loadDatabase];
    }
    return self;
}

- (void)loadDatabase {
    [NSKeyedUnarchiver setClass:[InputStickDeviceData class] forClassName:InputStickDatabaseClassName]; //required to maintain compatibility after renaming ISDeviceData to InputStickDeviceData
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:InputStickDatabaseKey];
    if (data == nil) {
        _deviceDbArray = [[NSMutableArray alloc] init];
        //backwards compatibility: add most recently used device to DB:
        NSString *storedIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:InputStickStoredIdentifierKey];
        if (storedIdentifier != nil) {
            [self createDeviceWithIdentifier:storedIdentifier withPreferredName:InputStickDatabaseDefaultDeviceName];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:InputStickStoredIdentifierKey];
            [self setMostRecentlyUsedDeviceIdentifierTo:storedIdentifier]; //set as the most recently used device
        }
    } else {
        NSArray<InputStickDeviceData *> *tmpArray = nil;
        @try {
            tmpArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        @catch (NSException *exception) {
            //TODO remove object for InputStickDatabaseKey???
        }
        if (tmpArray == nil) {
            _deviceDbArray = [[NSMutableArray alloc] init];
        } else {
            _deviceDbArray = [tmpArray mutableCopy];
        }
    }
    
    InputStickDeviceData *tmp;
    for (int i = 0; i < [_deviceDbArray count]; i++) {
        tmp = [_deviceDbArray objectAtIndex:i];
        tmp.db = self;
    }
}

- (void)storeDatabase {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_deviceDbArray];
    [userDefaults setObject:data forKey:InputStickDatabaseKey];
    [userDefaults synchronize];
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
    NSString *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:InputStickMostRecentDeviceKey];
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
    [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:InputStickMostRecentDeviceKey];
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
