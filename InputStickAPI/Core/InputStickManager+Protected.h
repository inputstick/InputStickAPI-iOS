/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @brief contains methods/fields used internally by InputStick API
 */

#import <Foundation/Foundation.h>
#import "InputStickManager.h"

typedef NS_ENUM(NSUInteger, InputStickErrorCode);

@interface InputStickManager (Protected)

- (void)presentErrorDialog:(NSError *)error;

- (void)presentKeyRemovedDialog:(InputStickDeviceData *)deviceData;

- (void)presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request;

- (void)presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData;


- (void)showErrorMessage:(NSError *)error;


- (void)processPacket:(InputStickRxPacket *)rxPacket;


- (void)disconnectWithErrorCode:(InputStickErrorCode)errorCode;

- (void)didDisconnect:(InputStickErrorCode)errorCode;


- (void)setConnectionState:(InputStickConnectionState)connectionState;

- (void)setUSBState:(InputStickUSBState)state;

- (void)setEncryptionStatus:(BOOL)enabled;

- (void)setFirmwareVersion:(NSUInteger)firmwareVersion;


- (void)setFirmwareManager:(id<InputStickFirmwareManagerProtocol>)firmwareManager;

/*!
 @brief returns InputStickDeviceData for currently connected Bluetooth UUID, if not found, creates and returns new entry
 @return InputStickDeviceData of connected device
 */
- (InputStickDeviceData *)addConectedDeviceToDatabase;

@end
