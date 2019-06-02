/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "InputStickManagerDelegate.h"

@class InputStickManager;
@class InputStickPreferences;

@interface InputStickMenuTableViewController : UITableViewController <InputStickManagerDelegate, InputStickConnectionNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

/*! set reference if you want preferences fields to be updates when user changes InputStick settings */
@property(nonatomic, weak) InputStickPreferences *preferences;

/*~ if TRUE, InputStickMenu View Controllers will not display InputStickBarButtonItem */
@property(nonatomic) BOOL hideBarButton;


@end
