/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>

@interface InputStickKeyboardLayoutSelectionTableViewController : UITableViewController

@property(nonatomic) NSString *key;

/*! NSUserDefaults used for storing data */
@property(nonatomic) NSUserDefaults *userDefaults;

#pragma mark - Object lifecycle
- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults key:(NSString *)key  layoutCode:(NSString *)layoutCode;

@end
