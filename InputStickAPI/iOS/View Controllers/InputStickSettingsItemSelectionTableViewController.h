/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>

@interface InputStickSettingsItemSelectionTableViewController : UITableViewController

@property(nonatomic) NSArray<NSString *> *displayItems;
@property(nonatomic) NSArray<NSString *> *infoItems;
@property(nonatomic) NSArray<NSString *> *storeValues;
@property(nonatomic) NSString *key;

/*! NSUserDefaults used for storing data */
@property(nonatomic) NSUserDefaults *userDefaults;

/*! if TRUE it indicates that there is another Settings UIViewController in stack (that should be popped once a value is selected) */
@property(nonatomic) BOOL subLevel;

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems storeValues:(NSArray<NSString *> *)storeValues infoItems:(NSArray<NSString *> *)infoItems userDefaults:(NSUserDefaults *)userDefaults subLevel:(BOOL)subLevel;

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems storeValues:(NSArray<NSString *> *)storeValues userDefaults:(NSUserDefaults *)userDefaults;

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems infoItems:(NSArray<NSString *> *)infoItems storeValues:(NSArray<NSString *> *)storeValues userDefaults:(NSUserDefaults *)userDefaults;

@end
