/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header MainTableViewController.h
 @brief Demo app Main Menu 
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "InputStickManagerDelegate.h"

@class InputStickManager;
@class InputStickPreferences;

@interface MainTableViewController : UITableViewController <InputStickManagerDelegate, InputStickConnectionNotificationObserver>

/*! allows to manage InputStick connection and access HID interface handlers */
@property(nonatomic, strong) InputStickManager *inputStickManager;
/*! InputStick-related user preferences */
@property(nonatomic, strong) InputStickPreferences *preferences;


#pragma mark - static methods

+ (InputStickManager *)getInputStickManager;

@end


