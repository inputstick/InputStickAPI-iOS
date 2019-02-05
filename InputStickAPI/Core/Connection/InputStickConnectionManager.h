/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickConnectionManager.h
 @brief manages Bluetooth connection, sends and receives data via Bluetooth
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "NSNotificationCenter+InputStickPeripheralScan.h"

typedef NS_ENUM(NSUInteger, InputStickErrorCode);
@class InputStickManager;
@class InputStickDeviceData;
@class InputStickPeripheralInfo;

@interface InputStickConnectionManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property(nonatomic, strong, readonly) CBCentralManager *bluetoothCentralManager;
@property(nonatomic, weak, readonly) InputStickManager *inputStickManager;

@property(nonatomic, strong, readonly) NSMutableArray<InputStickPeripheralInfo *> *foundPeripherals;

@property(nonatomic, readonly) CBPeripheral *connectedPeripheral;
@property(nonatomic, readonly) CBCharacteristic *discoveredCharacteristic;

@property(nonatomic, readonly) BOOL bluetoothSupported;
@property(nonatomic, readonly) BOOL bluetoothOn;


#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager;


#pragma mark - Connection-related methods

- (void)connectToPeripheralWithIdentifier:(NSString *)identifier orNearestStoredIfNotFound:(BOOL)allowNearestStored;

- (void)connectToNearestStoredPeripheral;

- (void)connectToPeripheral:(CBPeripheral *)peripheral;

- (void)disconnectCurrentDeviceWithErrorCode:(InputStickErrorCode)errorCode;


#pragma mark - BT scan

- (void)startBluetoothPeripheralScanWithTimeout:(BOOL)enableTimeout;

- (void)stopBluetoothPeripheralScan;

- (BOOL)hasDeviceBeenDiscovered:(NSString *)identifier;


#pragma mark - Send/Receive data

- (void)sendData:(NSData *)data;

@end
