/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickTheme.h
 @brief allows to customize theme for InputStickMenu
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, InputStickConnectionState);

@class InputStickDeviceTableViewCell;

@interface InputStickTheme : NSObject

+ (void)themeViewController:(UIViewController *)vc;
+ (void)themeTableViewHeaderView:(UITableViewHeaderFooterView *)header;
+ (void)themeTableViewCell:(UITableViewCell *)cell;
+ (void)themeNavigationBar:(UINavigationBar *)navBar;
+ (void)themeActivityIndicatorView:(UIActivityIndicatorView *)activityIndicator;
+ (void)themeRefreshControl:(UIRefreshControl *)refreshControl;

+ (UIColor *)themeNotificationColor:(UIColor *)color connectionState:(InputStickConnectionState)connectionState connectionError:(BOOL)connectionError;

@end
