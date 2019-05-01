/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickFirmwareManagerProtocol.h
 @brief used to initialize communication with InputStick (detect firmware version & settings, initialize firmware, authenticate, set required parameters etc.)
 @discussion Firmware Manager must take care of adding device to database and updating database entry with latest info received from the device (firmware version, encryption key, etc.)
 */

#import <Foundation/Foundation.h>

@class InputStickRxPacket;
@class InputStickDeviceData;

@protocol InputStickFirmwareManagerProtocol <NSObject>

/*!
 @brief called once Bluetooth connection is established
 @discussion it is now possible to send packets to initialize and configure firmware
 */
- (void)startInitialization;

/*!
 @brief called when Bluetooth connection is lost or user aborts connection
 */
- (void)reset;

/*!
 @brief called once packet is received from InputStick
 @param rxPacket packet to process
 */
- (void)processPacket:(InputStickRxPacket *)rxPacket;

/*!
 @brief called when user provides password (was requested by InputStickManager delegate callback)
 @param password password provided by user, if nil no password should be used
 */
- (void)updateDevicePassword:(NSString *)password;

@end
