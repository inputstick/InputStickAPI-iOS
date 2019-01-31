/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTheme.h"
#import "InputStickDeviceTableViewCell.h"
#import "InputStickConst.h"


@implementation InputStickTheme

//return TRUE if you want to customize InputStickMenu UI
//modify methods below to get desired customization
+ (BOOL)isCustomThemeEnabled {
    return FALSE; 
}

+ (void)themeView:(UIView *)view {
    if ([InputStickTheme isCustomThemeEnabled]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *uiLabel = (UILabel *)view;
            [uiLabel setTextColor:[UIColor whiteColor]];
            [uiLabel setBackgroundColor:[UIColor blackColor]];
        }
    }
}

+ (void)themeViewController:(UIViewController *)vc {
    if ([InputStickTheme isCustomThemeEnabled]) {
        vc.view.backgroundColor = [UIColor blackColor];
    }
}

+ (void)themeInputStickDeviceTableViewCell:(InputStickDeviceTableViewCell *)cell {
    if ([InputStickTheme isCustomThemeEnabled]) {
        cell.backgroundColor = [UIColor blackColor];
        cell.nameLabel.textColor = [UIColor whiteColor];
        cell.identifierLabel.textColor = [UIColor whiteColor];
    }
}

+ (void)themeTableViewHeaderView:(UITableViewHeaderFooterView *)header {
    if ([InputStickTheme isCustomThemeEnabled]) {
        [header.backgroundView setBackgroundColor:[UIColor blackColor]];
        UILabel *uiLabel = (UILabel *)header.textLabel;
        [uiLabel setTextColor:[UIColor whiteColor]];
        [uiLabel setBackgroundColor:[UIColor blackColor]];
    }
}

+ (void)themeTableViewCell:(UITableViewCell *)cell {
    if ([InputStickTheme isCustomThemeEnabled]) {
        [cell setBackgroundColor:[UIColor blackColor]];
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell setTintColor:[UIColor whiteColor]]; //table cell accessory
    }
}

+ (void)themeNavigationBar:(UINavigationBar *)navBar {
    if ([InputStickTheme isCustomThemeEnabled]) {
        navBar.barStyle = UIBarStyleBlack;
        navBar.barTintColor = [UIColor blackColor];
        navBar.tintColor = [UIColor whiteColor];
    }
}

+ (void)themeActivityIndicatorView:(UIActivityIndicatorView *)activityIndicator {
    if ([InputStickTheme isCustomThemeEnabled]) {
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
}

+ (void)themeRefreshControl:(UIRefreshControl *)refreshControl {
    if ([InputStickTheme isCustomThemeEnabled]) {
        refreshControl.backgroundColor = [UIColor blackColor];
        refreshControl.tintColor = [UIColor whiteColor];
    }
}

+ (UIColor *)themeNotificationColor:(UIColor *)color {
    if ([InputStickTheme isCustomThemeEnabled]) {
        //replace black color with white; leave other colors unchanged
        if ([color isEqual:[UIColor blackColor]]) {
            return [UIColor whiteColor];
        }
    }
    return color;
}


@end
