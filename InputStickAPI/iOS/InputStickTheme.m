/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickTheme.h"
#import "InputStickManager.h"
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
        if ([vc isKindOfClass:[UITableViewController class]]) {
            ((UITableViewController *)vc).tableView.separatorColor = [UIColor darkGrayColor];
        }
        vc.view.backgroundColor = [UIColor blackColor];
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
        cell.backgroundColor = [UIColor colorWithRed:28.f / 255.f green:28.f / 255.f blue: 30.f / 255.f alpha:1]; //=dark mode secondarySystemGroupedBackgroundColor
        if ([cell isKindOfClass:[InputStickDeviceTableViewCell class]]) {            
            ((InputStickDeviceTableViewCell *)cell).nameLabel.textColor = [UIColor whiteColor];
            ((InputStickDeviceTableViewCell *)cell).identifierLabel.textColor = [UIColor whiteColor];
        } else {
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            [cell setTintColor:[UIColor whiteColor]]; //table cell checkmark accessory
        }
    }
}

+ (void)themeNavigationBar:(UINavigationBar *)navBar {
    if ([InputStickTheme isCustomThemeEnabled]) {
        navBar.barStyle = UIBarStyleBlack;
        navBar.barTintColor = [UIColor blackColor];
        navBar.tintColor = [UIColor whiteColor]; //nav button text color
        if (@available(iOS 13, *)) {
            [navBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}]; //VC title text color
        }
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

+ (UIColor *)themeNotificationColor:(UIColor *)color connectionState:(InputStickConnectionState)connectionState connectionError:(BOOL)connectionError {
    if ([InputStickTheme isCustomThemeEnabled]) {
        if (connectionError) {
            return [UIColor redColor];
        }
        switch (connectionState) {
            case InputStickDisconnected:
                return [UIColor grayColor];
            case InputStickConnecting:
            case InputStickInitializing:
                return [UIColor colorWithRed:247.f / 255.f green:152.f / 255.f blue: 98.f / 255.f alpha:1]; //~lt orange
            case InputStickWaitingForUSB:
                return [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1]; //~orange
            case InputStickReady:
                return [UIColor colorWithRed: 62.f / 255.f green:146.f / 255.f blue:241.f / 255.f alpha:1]; //~blue
            default:
                return [UIColor grayColor];
        }
    }
    return color;
}


@end
