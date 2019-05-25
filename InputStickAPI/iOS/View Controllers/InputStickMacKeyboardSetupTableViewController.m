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
#import "InputStickKeyboardUtils.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickPreferences.h"
#import "InputStickConst.h"

static NSString *const CellReuseIdentifier = @"InputStickMacKeyboardSetupCellIdentifier";


@interface InputStickMacKeyboardSetupTableViewController () {
    InputStickKeyboardType _keyboardType;
    NSArray *_keyLabelsLUT;
}

@end


@implementation InputStickMacKeyboardSetupTableViewController

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TITLE", InputStickStringTable, nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    [InputStickTheme themeViewController:self];
    
    _keyLabelsLUT = [InputStickKeyboardUtils getKeyLabelsLUTForLayout:self.keyboardLayout];
    _keyboardType = [[self.keyboardLayout class] keyboardType];
    
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
    UIAlertController *alertController = [InputStickUI errorAlertDialog:error];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentEncryptionKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    UIAlertController *alertController = [InputStickUI encryptionKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData];
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
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TABLE_SECTION_KEY_LEFT", InputStickStringTable, nil);
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TABLE_SECTION_KEY_RIGHT", InputStickStringTable, nil);
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //do not dequeueReusableCell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellReuseIdentifier]; 
    [InputStickTheme themeTableViewCell:cell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_LAYOUT", InputStickStringTable, nil);
            cell.detailTextLabel.text = [[self.keyboardLayout class] layoutEnglishName];
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
        NSString *key;
        if (_keyboardType == KEYBOARD_ANSI) {
            key = [InputStickKeyboardUtils getLabelForKey:KEY_Z withModifiers:0x00 withKeyLabelsLUT:_keyLabelsLUT];
        } else {
            key = [InputStickKeyboardUtils getLabelForKey:KEY_BACKSLASH_NON_US withModifiers:0x00 withKeyLabelsLUT:_keyLabelsLUT];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_PRESS_KEY", InputStickStringTable, nil), key];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 2) {
        NSString *key;
        key = [InputStickKeyboardUtils getLabelForKey:KEY_SLASH withModifiers:0x00 withKeyLabelsLUT:_keyLabelsLUT];
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedStringFromTable(@"INPUTSTICK_MACOS_SETUP_TEXT_PRESS_KEY", InputStickStringTable, nil), key];
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
            if (_keyboardType == KEYBOARD_ANSI) {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_Z flush:YES];
            } else {
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_BACKSLASH_NON_US flush:YES];
            }
        }
    } else if (indexPath.section == 2) {
        if ([InputStickUI checkIfInputStickIsReady:self.inputStickManager viewController:self]) {
            [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_SLASH flush:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
