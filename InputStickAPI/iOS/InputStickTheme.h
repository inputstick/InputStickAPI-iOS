/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickTheme.h
 @brief allows to customize theme for InputStickMenu
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class InputStickDeviceTableViewCell;

@interface InputStickTheme : NSObject

+ (void)themeViewController:(UIViewController *)vc;
+ (void)themeInputStickDeviceTableViewCell:(InputStickDeviceTableViewCell *)cell;
+ (void)themeTableViewHeaderView:(UITableViewHeaderFooterView *)header;
+ (void)themeTableViewCell:(UITableViewCell *)cell;
+ (void)themeNavigationBar:(UINavigationBar *)navBar;
+ (void)themeActivityIndicatorView:(UIActivityIndicatorView *)activityIndicator;
+ (void)themeRefreshControl:(UIRefreshControl *)refreshControl;

+ (UIColor *)themeNotificationColor:(UIColor *)color;

@end
