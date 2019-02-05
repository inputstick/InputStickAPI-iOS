/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickDeviceDB.h
 @brief stores InputStickDeviceData for previously connected InputStick devices
 */

#import <Foundation/Foundation.h>

@class InputStickDeviceData;

@interface InputStickDeviceDB : NSObject

@property (nonatomic, readonly) NSMutableArray<InputStickDeviceData *> *deviceDbArray;
@property (nonatomic, readonly) NSUInteger numberOfStoredDevices;

- (void)storeDatabase;
- (BOOL)hasDeviceWithIdentifier:(NSString *)identifier;
- (InputStickDeviceData *)getDataForDeviceWithIdentifier:(NSString *)identifier;
- (BOOL)createDeviceWithIdentifier:(NSString *)identifier withPreferredName:(NSString *)preferredName;
- (void)deleteDeviceWithIndex:(NSUInteger)index;
- (void)deleteDeviceWithIdentifier:(NSString *)identifier;
- (void)swapDeviceFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex updateDatabase:(BOOL)update;


#pragma mark - Most recently used InputStick

/*!
 @brief Bluetooth UUID of the most recently connected InputStick or nil if there are no saved devices
 @return Bluetooth UUID
 */
- (NSString *)getMostRecentlyUsedDeviceIdentifier;

/*!
 @brief sets Bluetooth UUID of the most recently connected device
 @param identifier Bluetooth UUID
 */
- (void)setMostRecentlyUsedDeviceIdentifierTo:(NSString *)identifier;


#pragma mark - Name helpers

/*!
 @brief checks if device with provided name is already stored in database
 @param name device database name
 */
- (BOOL)canUseName:(NSString *)name;

/*!
 @brief returns name which can be stored in database, based on provided preferred name for the device
 @param preferredName preferred name for the device
 @return name which can be stored in database
 @discussion if it is not already in use, preferredName will be returned, if not, "-1", "-2" etc. will be added
 */
- (NSString *)getNextAvailableName:(NSString *)preferredName;

@end
