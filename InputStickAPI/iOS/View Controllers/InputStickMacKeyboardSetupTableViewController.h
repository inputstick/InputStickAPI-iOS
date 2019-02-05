/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>
#import "InputStickManagerDelegate.h"

@class InputStickManager;
@protocol InputStickKeyboardLayoutProtocol;

@interface InputStickMacKeyboardSetupTableViewController : UITableViewController <InputStickManagerDelegate>

@property(nonatomic, weak) InputStickManager *inputStickManager;
@property(nonatomic, strong) id <InputStickKeyboardLayoutProtocol> keyboardLayout;
@property(nonatomic) BOOL hideBarButton;

@end
