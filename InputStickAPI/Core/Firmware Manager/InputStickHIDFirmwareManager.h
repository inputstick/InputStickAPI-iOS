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
    InputStickFirmwareInitStateStarted = 1, /*! received firmware info packet */
    InputStickFirmwareInitStateAuthenticating = 2,
    InputStickFirmwareInitStateAuthenticated = 3,
    InputStickFirmwareInitStateCompleted,  /*! firmware initialization completed. USB interface may not be ready to use yet */
};

@interface InputStickHIDFirmwareManager : NSObject<InputStickFirmwareManagerProtocol>


#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

@end
