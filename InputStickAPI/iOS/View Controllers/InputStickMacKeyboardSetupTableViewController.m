/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickMacKeyboardSetupTableViewController.h"
#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickKeyboardHandler.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickKeyLabels.h"
#import "InputStickPreferences.h"
#import "InputStickConst.h"

static NSString *const CellReuseIdentifier = @"InputStickMacKeyboardSetupCellIdentifier";


@interface InputStickMacKeyboardSetupTableViewController () {
    InputStickKeyboardType _keyboardType;
    InputStickKeyLabels *_keyLabels;
}

@end


@implementation InputStickMacKeyboardSetupTableViewController

#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TITLE", InputStickStringTable, nil);
    //do not registerClass forCellReuseIdentifier! we need UITableViewCellStyleValue1! see cellForRowAtIndexPath
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    [InputStickTheme themeViewController:self];
    
    _keyLabels = [self.keyboardLayout keyLabels];
    _keyboardType = [self.keyboardLayout keyboardType];
    
    if ( !_hideBarButton) {
        InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputStickManager.inputStickMenuDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.inputStickManager.inputStickMenuDelegate = nil;
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
        return 2;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TABLE_SECTION_LAYOUT_INFO", InputStickStringTable, nil);
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {    
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_FOOTER_INFO", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_FOOTER_KEY1", InputStickStringTable, nil);
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_FOOTER_KEY2", InputStickStringTable, nil);
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellReuseIdentifier];
        [InputStickTheme themeTableViewCell:cell];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_LAYOUT", InputStickStringTable, nil);
            cell.detailTextLabel.text = [self.keyboardLayout layoutDisplayName];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_LAYOUT_TYPE", InputStickStringTable, nil);
            if (_keyboardType == KEYBOARD_ISO) {
                cell.detailTextLabel.text = @"ISO";
            } else if (_keyboardType == KEYBOARD_ANSI) {
                cell.detailTextLabel.text = @"ANSI";
            } else if (_keyboardType == KEYBOARD_JIS) {
                cell.detailTextLabel.text = @"JIS";
            }
        }
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 1) {
        NSString *keyLabel;
        if (_keyboardType == KEYBOARD_ISO) {
            keyLabel = [_keyLabels labelForKey:KEY_BACKSLASH_NON_US];
        } else if (_keyboardType == KEYBOARD_ANSI) {
            keyLabel = [_keyLabels labelForKey:KEY_Z];
        } else if (_keyboardType == KEYBOARD_JIS) {
            keyLabel = [_keyLabels labelForKey:KEY_Z];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_PRESS_KEY", InputStickStringTable, nil), keyLabel];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 2) {
        NSString *keyLabel;
        if (_keyboardType == KEYBOARD_ISO) {
            keyLabel = [_keyLabels labelForKey:KEY_SLASH];
        } else if (_keyboardType == KEYBOARD_ANSI) {
            keyLabel = [_keyLabels labelForKey:KEY_SLASH];
        } else if (_keyboardType == KEYBOARD_JIS) {
            keyLabel = [_keyLabels labelForKey:KEY_INT_1];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_PRESS_KEY", InputStickStringTable, nil), keyLabel];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell = nil;
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        [InputStickTheme themeTableViewHeaderView:(UITableViewHeaderFooterView *)view];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if ([InputStickUI checkIfInputStickIsReady:self.inputStickManager viewController:self]) {
            if (_keyboardType == KEYBOARD_ISO) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_BACKSLASH_NON_US flush:YES];
            } else if (_keyboardType == KEYBOARD_ANSI) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_Z flush:YES];
            } else if (_keyboardType == KEYBOARD_JIS) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_Z flush:YES];
            }
        }
    } else if (indexPath.section == 2) {
        if ([InputStickUI checkIfInputStickIsReady:self.inputStickManager viewController:self]) {
            if (_keyboardType == KEYBOARD_ISO) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_SLASH flush:YES];
            } else if (_keyboardType == KEYBOARD_ANSI) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_SLASH flush:YES];
            } else if (_keyboardType == KEYBOARD_JIS) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_INT_1 flush:YES];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
