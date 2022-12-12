/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickMenuTableViewController.h"
#import "InputStickDeviceManagementTableViewController.h"
#import "InputStickMacKeyboardSetupTableViewController.h"
#import "InputStickDeviceSelectionTableViewController.h"
#import "InputStickSettingsTableViewController.h"
#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickDeviceData.h"
#import "InputStickDeviceDB.h"
#import "InputStickPreferences.h"
#import "InputStickPreferencesHelper.h"
#import "InputStickError.h"
#import "InputStickConst.h"


static NSString *const CellReuseIdentifier = @"InputStickMenuCellIdentifier";


@interface InputStickMenuTableViewController () {
    UIActivityIndicatorView *_connectionActivityIndicatorView;
    InputStickConnectionState _connectionState;
    InputStickConnectionButtonAction _connectionActionPrimary;
    InputStickConnectionButtonAction _connectionActionSecondary;
}

@end


@implementation InputStickMenuTableViewController

#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
        

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TITLE", InputStickStringTable, nil);
    //do not registerClass forCellReuseIdentifier! we need UITableViewCellStyleValue1! for section 0, row 0 see cellForRowAtIndexPath
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_BACK", InputStickStringTable, nil)
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    if (@available(iOS 13, *)) {
        _connectionActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    } else {
        _connectionActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    [InputStickTheme themeViewController:self];
    [InputStickTheme themeActivityIndicatorView:_connectionActivityIndicatorView];
    [InputStickTheme themeNavigationBar:self.navigationController.navigationBar];
    
    if ( !_hideBarButton) {
        InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
    
    //makes sure that preferences are initialized
    [_preferences loadFromUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputStickManager.inputStickMenuDelegate = self;
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
    [self updateDeviceConnectionStatus];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.inputStickManager.inputStickMenuDelegate = nil;
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self];
    [super viewWillDisappear:animated];
}


#pragma mark - InputStickManager Delegate

- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error {
    if (error.code == INPUTSTICK_ERROR_BT_OUT_OF_RANGE) {
        [self showConnectionToMostRecentlyUsedDeviceFailedDialog];
    } else {
        UIAlertController *alertController = [InputStickUI errorAlertDialog:inputStickManager error:error];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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

- (void)inputStickManager:(InputStickManager *)inputStickManager presentUSBResumeDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI usbResumeAlertDialog:inputStickManager deviceData:deviceData viewController:self];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - InputStickConnectionNotifications Observer

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    [self updateDeviceConnectionStatus];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_connectionActionSecondary == InputStickConnectionButtonActionNone) {
            return 2; //status + primary action button
        } else {
            return 3; //status + primary action button + secondary action button
        }
    } else if (section == 1) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.textColor = [InputStickUI labelColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [InputStickTheme themeTableViewCell:cell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellReuseIdentifier];
            [InputStickTheme themeTableViewCell:cell];
        }
    }    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [InputStickUI inputStickStateInfo:self.inputStickManager];
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            if (_connectionState == InputStickReady || _connectionState == InputStickDisconnected) {
                [_connectionActivityIndicatorView stopAnimating];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.accessoryView = nil;
            } else {
                [_connectionActivityIndicatorView startAnimating];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.accessoryView = _connectionActivityIndicatorView;
            }
        } else if (indexPath.row == 1) {
            [cell.textLabel setText:[InputStickUI nameForInputStickConnectionButtonAction:_connectionActionPrimary]];
            if (_connectionActionPrimary == InputStickConnectionButtonActionConnectDiscoverDevices) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 2) {
            [cell.textLabel setText:[InputStickUI nameForInputStickConnectionButtonAction:_connectionActionSecondary]];
            if (_connectionActionSecondary == InputStickConnectionButtonActionConnectDiscoverDevices) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_MANAGE_DEVICES", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_SETTINGS", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_MAC_SETUP", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_ABOUT", InputStickStringTable, nil);
        } else if (indexPath.row == 4) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_UTILITY_OPEN", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else {
        cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TABLE_SECTION_CONNECTION", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TABLE_SECTION_UTILS", InputStickStringTable, nil);
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_FOOTER_UTILS", InputStickStringTable, nil);
    } else {
        return nil;
    }
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        [InputStickTheme themeTableViewHeaderView:(UITableViewHeaderFooterView *)view];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self performConnectionAction:_connectionActionPrimary];
        } else if (indexPath.row == 2) {
            [self performConnectionAction:_connectionActionSecondary];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (_connectionState == InputStickDisconnected) {
                UIViewController *vc = [[InputStickDeviceManagementTableViewController alloc] initWithInputStickManager:self.inputStickManager];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [InputStickUI showDisconnectDialog:self.inputStickManager viewController:self];
            }
        } else if (indexPath.row == 1) {
            UIViewController *vc = [[InputStickSettingsTableViewController alloc] init];
            ((InputStickSettingsTableViewController *)vc).inputStickManager = self.inputStickManager;
            ((InputStickSettingsTableViewController *)vc).preferences = self.preferences;
            ((InputStickSettingsTableViewController *)vc).hideBarButton = self.hideBarButton;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            if ([InputStickUI checkIfInputStickIsReady:_inputStickManager viewController:self]) {
                UIViewController *vc = [[InputStickMacKeyboardSetupTableViewController alloc] init];
                ((InputStickMacKeyboardSetupTableViewController *)vc).keyboardLayout = self.preferences.keyboardLayout;
                ((InputStickMacKeyboardSetupTableViewController *)vc).inputStickManager = self.inputStickManager;
                ((InputStickMacKeyboardSetupTableViewController *)vc).hideBarButton = self.hideBarButton;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } else if (indexPath.row == 3) {
            [InputStickUI showAlertWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TITLE_ABOUT", InputStickStringTable, nil)
                                     message:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TEXT_ABOUT", InputStickStringTable, nil)
                                         url:[NSURL URLWithString:InputStickWebpageURL]
                              viewController:self];
        } else if (indexPath.row == 4) {
            //launch Utility app or get from iTunes if not installed; disconnect (to make sure that Utility app will be able to connect)
            [self.inputStickManager disconnectFromInputStick];
            NSURL *url = [NSURL URLWithString:InputStickUtilityLaunchURL];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                UIAlertController *alertController = [InputStickUI downloadInputStickUtilityAlertDialog];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Connection helpers

- (void)updateDeviceConnectionStatus {
    _connectionState = self.inputStickManager.connectionState;
    switch (_connectionState) {
        case InputStickDisconnected:
            if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                _connectionActionPrimary = InputStickConnectionButtonActionConnectLastDevice;
                _connectionActionSecondary = InputStickConnectionButtonActionConnectDiscoverDevices;
            } else {
                _connectionActionPrimary = InputStickConnectionButtonActionConnectDiscoverDevices;
                _connectionActionSecondary = InputStickConnectionButtonActionNone;
            }
            break;
        case InputStickConnecting:
        case InputStickInitializing:
        case InputStickUSBNotReady:
            _connectionActionPrimary = InputStickConnectionButtonActionCancel;
            _connectionActionSecondary = InputStickConnectionButtonActionNone;
            break;
        case InputStickUSBSuspended:
            _connectionActionPrimary = InputStickConnectionButtonActionDisconnect;
            _connectionActionSecondary = InputStickConnectionButtonActionUSBResume;
            break;
        case InputStickReady:
            _connectionActionPrimary = InputStickConnectionButtonActionDisconnect;
            _connectionActionSecondary = InputStickConnectionButtonActionNone;
            break;
    }
    [self.tableView reloadData];  //do not reload just a single section!
}

- (void)performConnectionAction:(InputStickConnectionButtonAction)connectionAction {
    switch (connectionAction) {
        case InputStickConnectionButtonActionNone:
            break;
        case InputStickConnectionButtonActionConnectLastDevice:
            if ([InputStickUI checkIfBluetoothIsOn:_inputStickManager viewController:self]) {
                [self.inputStickManager connectToLastInputStick];
            }
            break;
        case InputStickConnectionButtonActionConnectDiscoverDevices:
            if ([InputStickUI checkIfBluetoothIsOn:_inputStickManager viewController:self]) {
                InputStickDeviceSelectionTableViewController *vc = [[InputStickDeviceSelectionTableViewController alloc] initWithInputStickManager:self.inputStickManager];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case InputStickConnectionButtonActionCancel:
        case InputStickConnectionButtonActionDisconnect:
            [self.inputStickManager disconnectFromInputStick];
            break;
        case InputStickConnectionButtonActionUSBResume:
            [self.inputStickManager sendUSBResumeRequest];
            break;
    }
}


#pragma mark Dialogs

- (void)showConnectionToMostRecentlyUsedDeviceFailedDialog {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TITLE_CONNECT_LAST_FAILED", InputStickStringTable, nil)
                                                          message:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TEXT_CONNECT_LAST_FAILED", InputStickStringTable, nil)
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *discoverAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_YES", InputStickStringTable, nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [weakSelf performConnectionAction:InputStickConnectionButtonActionConnectDiscoverDevices];
                                                           }];
    [alertController addAction:discoverAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
