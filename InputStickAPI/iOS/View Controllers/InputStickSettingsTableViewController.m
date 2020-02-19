/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickSettingsTableViewController.h"
#import "InputStickSettingsItemSelectionTableViewController.h"
#import "InputStickKeyboardLanguageSelectionTableViewController.h"
#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickPreferences.h"
#import "InputStickPreferencesHelper.h"
#import "InputStickConst.h"


static NSString *const CellReuseIdentifier = @"InputStickSettingsCell";


@implementation InputStickSettingsTableViewController

#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE", InputStickStringTable, nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_BACK", InputStickStringTable, nil)
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil
                                   ];
    self.navigationItem.backBarButtonItem = backButton;
    
    [InputStickTheme themeViewController:self];
        
    if ( !_hideBarButton) {
        InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
    
    [self.preferences loadFromUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputStickManager.inputStickMenuDelegate = self;
    [_preferences loadFromUserDefaults];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.inputStickManager.inputStickMenuDelegate = nil;
    if (self.preferences != nil) {
        [self.preferences loadFromUserDefaults];
    }
    [super viewWillDisappear:animated];
}


#pragma mark - InputStickManager Delegate

- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error {
    UIAlertController *alertController = [InputStickUI errorAlertDialog:inputStickManager error:error];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)inputStickManager:(InputStickManager *)inputStickManager presentEncryptionKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    UIAlertController *alertController = [InputStickUI encryptionKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    [self presentViewController:alertController animated:YES completion:nil];
    return TRUE;
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData viewController:self];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 5;
    } else {
        return 0;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TABLE_SECTION_CONNECTION", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TABLE_SECTION_KEYBOARD", InputStickStringTable, nil);
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TABLE_SECTION_MOUSE", InputStickStringTable, nil);
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //do not dequeueReusableCell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellReuseIdentifier];
    [InputStickTheme themeTableViewCell:cell];
    
    InputStickSettingsItem item = [self getItemAtIndexPath:indexPath];
    if (item != InputStickSettingsItemNone) {
        cell.textLabel.text = [InputStickPreferencesHelper nameForItem:item];
        cell.detailTextLabel.text = [InputStickPreferencesHelper displayValueForItem:item userDefaults:self.preferences.userDefaults];
        
        //special case for sensitivity/ratio settings
        if (indexPath.section == 2) {
            if (indexPath.row == 2) {
                if (_preferences.touchScreenMode) {
                    //display info that mousepad sensitivity requires mouse mode to be enabled
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellReuseIdentifier];
                    [InputStickTheme themeTableViewCell:cell];
                    cell.textLabel.text = [InputStickPreferencesHelper nameForItem:item];
                    cell.detailTextLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TEXT_REQUIRES_MOUSE_MODE", InputStickStringTable, nil);
                    cell.userInteractionEnabled = NO;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.textColor = [UIColor grayColor];
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                }
            }
            if (indexPath.row == 3) {
                if ( !_preferences.touchScreenMode) {
                    //display info that mousepad ratio requires touch-screen mode to be enabled
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellReuseIdentifier];
                    [InputStickTheme themeTableViewCell:cell];
                    cell.textLabel.text = [InputStickPreferencesHelper nameForItem:item];
                    cell.detailTextLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TEXT_REQUIRES_TOUCH_SCREEN_MODE", InputStickStringTable, nil);
                    cell.userInteractionEnabled = NO;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.textColor = [UIColor grayColor];
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                }
            }
        }
    } else {
        cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
        cell.detailTextLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        [InputStickTheme themeTableViewHeaderView:(UITableViewHeaderFooterView *)view];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    NSString *name;
    NSString *key;
    NSArray<NSString *> *displayValues;
    NSArray<NSString *> *storeValues;
    
    InputStickSettingsItem item = [self getItemAtIndexPath:indexPath];
    if (item == InputStickSettingsItemKeyboardLayout) {
        //special case
        vc = [[InputStickKeyboardLanguageSelectionTableViewController alloc] initWithUserDefaults:self.preferences.userDefaults];
    } else if (item != InputStickSettingsItemNone) {
        name = [InputStickPreferencesHelper nameForItem:item];
        key = [InputStickPreferencesHelper keyForItem:item];
        displayValues = [InputStickPreferencesHelper displayValuesForItem:item];
        storeValues = [InputStickPreferencesHelper storeValuesForItem:item];
        vc = [[InputStickSettingsItemSelectionTableViewController alloc] initWithTitle:name
                                                                                   key:key
                                                                          displayItems:displayValues
                                                                           storeValues:storeValues
                                                                          userDefaults:self.preferences.userDefaults];        
    }
    
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (InputStickSettingsItem)getItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return InputStickSettingsItemAutoConnect;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return InputStickSettingsItemKeyboardLayout;
        } else if (indexPath.row == 1) {
            return InputStickSettingsItemTypingSpeed;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return InputStickSettingsItemMouseMode;
        } else if (indexPath.row == 1) {
            return InputStickSettingsItemTapToClick;
        } else if (indexPath.row == 2) {
            return InputStickSettingsItemMouseSensitivity;
        } else if (indexPath.row == 3) {
            return InputStickSettingsItemMousepadRatio;
        } else if (indexPath.row == 4) {
            return InputStickSettingsItemScrollSensitivity;
        }
    }
    return InputStickSettingsItemNone;
}


@end
