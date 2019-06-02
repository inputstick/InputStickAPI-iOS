/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>
#import "InputStickManagerDelegate.h"

@class InputStickManager;
@class InputStickPreferences;

@interface InputStickSettingsTableViewController : UITableViewController <InputStickManagerDelegate>

@property(nonatomic, weak) InputStickManager *inputStickManager;
@property(nonatomic, weak) InputStickPreferences *preferences;

/*~ if TRUE, view will not display InputStickBarButtonItem */
@property(nonatomic) BOOL hideBarButton;


@end
