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
    UITableViewCell *_statusTableViewCell;
    InputStickConnectionState _connectionState;
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
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
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


#pragma mark - InputStickConnectionNotifications Observer

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    [self updateDeviceConnectionStatus];
}

- (void)updateDeviceConnectionStatus {
    _connectionState = self.inputStickManager.connectionState;
    [self.tableView reloadData];  //do not reload just a single section!
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_connectionState == InputStickDisconnected) {
            if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                return 3; //status + connect (last) + connect (discover)
            } else {
                return 2; //status + connect (discover)
            }
        } else {
            return 2; //status + disconnect
        }
    } else if (section == 1) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (cell == nil) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellReuseIdentifier];
            _statusTableViewCell = cell;
            _statusTableViewCell.textLabel.textColor = [InputStickUI labelColor];
            [_statusTableViewCell setUserInteractionEnabled:NO]; //important! set color first!
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellReuseIdentifier];
        }
    }    
    [InputStickTheme themeTableViewCell:cell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _statusTableViewCell.detailTextLabel.text = [self connectionStatusText];
            _statusTableViewCell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            if (_connectionState == InputStickReady || _connectionState == InputStickDisconnected) {
                [self hideBusyAccessory];
            } else {
                [self showBusyAccessory];
            }
        } else if (indexPath.row == 1) {
            if (_connectionState == InputStickDisconnected) {
                if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                    //connect (last)
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_LAST", InputStickStringTable, nil);
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    // connect (discover)
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_MANUALLY_SELECTED", InputStickStringTable, nil);
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            } else {
                if (_connectionState == InputStickReady) {
                    //disconnect
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISCONNECT", InputStickStringTable, nil);
                } else {
                    //cancel
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil);
                }
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 2) {
            //connect (discover)
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_MANUALLY_SELECTED", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 4) {
            cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_UTILITY_OPEN", InputStickStringTable, nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else {
        cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
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
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            if (_connectionState == InputStickDisconnected) {
                if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                    //connect (last)
                    [self connectToMostRecentlyUsedDevice];
                } else {
                    //connect (discover) + SHOW INFO
                    [self showFirstConnectionInfoDialog];
                }
            } else {
                //disconnect / cancel
                [self.inputStickManager disconnectFromInputStick];
            }
        } else if (indexPath.row == 2) {
            //connect (discover)
            [self connectToManuallySelectedDevice];
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
            [self showAboutInputStickDialog];
        } else if (indexPath.row == 4) {
            //launch Utility app or get from iTunes if not installed; disconnect (to make sure that Utility app will be able to connect)
            [self.inputStickManager disconnectFromInputStick];
            NSURL *url = [NSURL URLWithString:InputStickUtilityLaunchURL];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                if (@available(iOS 10, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            } else {
                UIAlertController *alertController = [InputStickUI downloadInputStickUtilityAlertDialog];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark Connection helpers

- (void)connectToManuallySelectedDevice {
    if ([InputStickUI checkIfBluetoothIsOn:_inputStickManager viewController:self]) {
        InputStickDeviceSelectionTableViewController *vc = [[InputStickDeviceSelectionTableViewController alloc] initWithInputStickManager:self.inputStickManager];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)connectToMostRecentlyUsedDevice {
    if ([InputStickUI checkIfBluetoothIsOn:_inputStickManager viewController:self]) {
        [self.inputStickManager connectToLastInputStick];
    }
}


#pragma mark Status cell helpers

- (NSString *)connectionStatusText {
    NSString *tmp = [InputStickUI nameForInputStickConnectionState:_connectionState];
    //add device name
    if (self.inputStickManager.connectedInputStickIdentifier != nil) {
        InputStickDeviceData *deviceData = [self.inputStickManager.deviceDB getDataForDeviceWithIdentifier:self.inputStickManager.connectedInputStickIdentifier];
        tmp = [tmp stringByAppendingString: @" ("];
        tmp = [tmp stringByAppendingString:deviceData.name];
        tmp = [tmp stringByAppendingString:@")"];
    }
    return tmp;
}

- (void)showBusyAccessory {
    [_connectionActivityIndicatorView startAnimating];
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryNone;
    _statusTableViewCell.accessoryView = _connectionActivityIndicatorView;
}

- (void)hideBusyAccessory {
    [_connectionActivityIndicatorView stopAnimating];
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryNone;
    _statusTableViewCell.accessoryView = nil;
}


#pragma mark Dialogs

- (void)showFirstConnectionInfoDialog {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TITLE_1ST_CONNECTION_INFO", InputStickStringTable, nil)
                                                          message:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TEXT_1ST_CONNECTION_INFO", InputStickStringTable, nil)
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_BUTTON_CONTINUE", InputStickStringTable, nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [weakSelf connectToManuallySelectedDevice];
                                                           }];
    [alertController addAction:continueAction];
    
    UIAlertAction *webpageAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_BUTTON_OPEN_WEBPAGE", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              if (@available(iOS 10, *)) {
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL] options:@{} completionHandler:nil];
                                                              } else {
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL]];
                                                              }
                                                          }];
    [alertController addAction:webpageAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showConnectionToMostRecentlyUsedDeviceFailedDialog {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TITLE_CONNECT_LAST_FAILED", InputStickStringTable, nil)
                                                          message:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TEXT_CONNECT_LAST_FAILED", InputStickStringTable, nil)
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *discoverAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_YES", InputStickStringTable, nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [weakSelf connectToManuallySelectedDevice];
                                                           }];
    [alertController addAction:discoverAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showAboutInputStickDialog {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TITLE_ABOUT", InputStickStringTable, nil)
                                                                             message:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_TEXT_ABOUT", InputStickStringTable, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *webpageAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_MENU_DIALOG_BUTTON_OPEN_WEBPAGE", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              if (@available(iOS 10, *)) {
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL] options:@{} completionHandler:nil];
                                                              } else {
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL]];
                                                              }
                                                          }];
    [alertController addAction:webpageAction];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:dismissAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
