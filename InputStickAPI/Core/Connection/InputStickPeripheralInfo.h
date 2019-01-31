/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickPeripheralInfo.h
 @brief contains data associated with nearby InputStick device obtained while scanning for nearby Bluetooth peripherals
 */

#import <Foundation/Foundation.h>

@class CBPeripheral;

@interface InputStickPeripheralInfo : NSObject

/*! Bluetooth UUID as NString */
@property(nonatomic, copy) NSString* identifier;

/*! Bluetooth name */
@property(nonatomic, copy) NSString* name;

/*! remote peripheral */
@property(nonatomic, strong) CBPeripheral* peripheral;

/*! last time the peripheral was discovered by CBCentralManager  */
@property(nonatomic) NSUInteger lastSeenTime;

/*! most recent signal strength */
@property(nonatomic) NSInteger rssi;

@end
