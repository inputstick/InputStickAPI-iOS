//
// Created by Marcin Wieclawski on 06/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ISDeviceStatusProvider.h"

@class ISDeviceStatusProvider;


extern NSString *const InputStickStoredIdentifierKey;
extern NSString *ISErrorDomain;

typedef NS_ENUM(NSInteger, ISErrorCodes) {
    ISConnectionTimeoutErrorCode,
    ISConnectionEnryptionErrorCode
};

@interface ISConnectionManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate, ConnectionNotificationObserver>
@property(nonatomic, strong, readonly) CBCentralManager *bluetoothCentralManager;
@property(nonatomic, weak, readonly) ISDeviceStatusProvider *deviceStatusProvider;
@property(nonatomic, weak, readonly) ISManager *manager;

@property(nonatomic, strong) NSMutableArray *foundPeripherals;
@property(nonatomic, strong) NSString *selectedDeviceIdentifier;

@property(nonatomic, readonly) CBPeripheral *connectedPeripheral;
@property(nonatomic, readonly) CBCharacteristic *discoveredCharacteristic;

#pragma mark - Connection operators

- (instancetype)initWithManager:(ISManager *)manager deviceStatusProvider:(ISDeviceStatusProvider *)deviceStatusProvider;

- (void)connectToPeripheral:(CBPeripheral *)peripheral;

- (void)connectToPeripheralWithIdentifier:(NSString *)identifier;

- (void)disconnectCurrentDevice;

#pragma mark - Static Methods

+ (NSString *)inputStickDeviceIdentifier;

+ (void)setInputStickDeviceIdentifier:(NSString *)identifier;

@end
