/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header ConnectionTableViewController.h
 @brief shows how to manage InputStick connection
 @discussion this demo shows how to manage connection in your app, if you want to implement this functionality yourself.
 For out of the box solution, see InputStickMenuTableViewController (/iOS/View Controllers)
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"

@class InputStickManager;

@interface ConnectionTableViewController : UITableViewController <InputStickConnectionNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
