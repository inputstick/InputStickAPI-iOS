/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickHIDFirmwareManager.h
 @brief performs default initialization of connected InputStick device
 @discussion the Firmware Manager will run main firmware, retrieve device info, authenticate and setup additional parameters depending on firmware version
 */

#import <Foundation/Foundation.h>
#import "InputStickFirmwareManagerProtocol.h"

@class InputStickManager;

//InputStickFirmwareInitState refers only to InputStick firmware initialization process, USB enumeration is separate issue
typedef NS_ENUM(Byte, InputStickFirmwareInitState) {
    InputStickFirmwareInitStateNone = 0,
    InputStickFirmwareInitStateInfo = 1, /*! received firmware info packet */
    InputStickFirmwareInitStateAuthenticated = 2,
    InputStickFirmwareInitStateConfigured = 3, /*! sent all configuration packets */
    InputStickFirmwareInitStateCompletedUSBNotReady = 4,  /*! received at least 1 update packet after firmware configuration was completed, USB interface is NOT ready */
    InputStickFirmwareInitStateCompletedUSBReady = 5,  /*! received at least update packet after firmware configuration was completed, USB interface is ready */
};

@interface InputStickHIDFirmwareManager : NSObject<InputStickFirmwareManagerProtocol>


#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

@end
