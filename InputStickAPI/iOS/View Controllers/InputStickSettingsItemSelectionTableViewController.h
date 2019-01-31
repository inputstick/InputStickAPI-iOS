/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>

@interface InputStickSettingsItemSelectionTableViewController : UITableViewController

@property(nonatomic) NSArray<NSString *> *displayValues;
@property(nonatomic) NSArray<NSString *> *storeValues;
@property(nonatomic) NSString *key;

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayValues storeValues:(NSArray<NSString *> *)storeValues;

@end
