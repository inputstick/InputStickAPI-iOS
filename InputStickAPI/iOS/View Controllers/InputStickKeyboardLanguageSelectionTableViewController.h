/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import <UIKit/UIKit.h>

@interface InputStickKeyboardLanguageSelectionTableViewController : UITableViewController

/*! NSUserDefaults used for storing data */
@property(nonatomic) NSUserDefaults *userDefaults;
/*! NSUserDefaults keyboard layout key */
@property(nonatomic) NSString *key;

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults key:(NSString *)key;

@end
