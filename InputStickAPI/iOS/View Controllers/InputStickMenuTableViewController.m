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
    InputStickConnectionState _connectionState;
    BOOL _inputStickUtilityPresent; //is InputStickUtility app installed?
}

@end


@implementation InputStickMenuTableViewController


- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TITLE", InputStickStringTable, nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_BACK", InputStickStringTable, nil)
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    [InputStickTheme themeViewController:self];
    [InputStickTheme themeNavigationBar:self.navigationController.navigationBar];
    
    if ( !_hideBarButton) {
        InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }
    
    _inputStickUtilityPresent = FALSE; //TODO update when it will be possible to detect if Utility app is installed
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
        UIAlertController *alertController = [InputStickUI errorAlertDialog:error];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentKeyRemovedDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI keyRemovedAlertDialog:inputStickManager deviceData:deviceData];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    UIAlertController *alertController = [InputStickUI provideKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData];
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
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TABLE_SECTION_STATUS", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TABLE_SECTION_CONNECTION", InputStickStringTable, nil);
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TABLE_SECTION_UTILS", InputStickStringTable, nil);
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    //return @"test";
    if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_MENU_FOOTER_UTILS", InputStickStringTable, nil);
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (_connectionState == InputStickDisconnected) {
            if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                return 2; //connect (last) / connect (discover)
            } else {
                return 1; //connect (discover)
            }
        } else {
            return 1; //disconnect
        }
    } else if (section == 2) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];    
    [InputStickTheme themeTableViewCell:cell];
    
    if (indexPath.section == 0) {
        NSString *tmp = [InputStickUI nameForInputStickConnectionState:_connectionState];
        //add device name
        NSString *connectedIdentifier = self.inputStickManager.connectedInputStickIdentifier;
        if (connectedIdentifier != nil) {
            InputStickDeviceData *deviceData = [self.inputStickManager.deviceDB getDataForDeviceWithIdentifier:connectedIdentifier];
            tmp = [tmp stringByAppendingString: @" ("];
            tmp = [tmp stringByAppendingString:deviceData.name];
            tmp = [tmp stringByAppendingString:@")"];
        }
        
        cell.textLabel.text = tmp;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    } else if (indexPath.section == 1) {
        if (_connectionState == InputStickDisconnected) {
            if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                if (indexPath.row == 0) {
                    //connect (last)
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_LAST", InputStickStringTable, nil);
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } else if (indexPath.row == 1) {
                    // connect (discover)
                    cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_MANUALLY_SELECTED", InputStickStringTable, nil);
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            } else {
                //connect (discover)
                cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_MANUALLY_SELECTED", InputStickStringTable, nil);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else {
            //disconnect
            if (_connectionState == InputStickReady) {
                cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISCONNECT", InputStickStringTable, nil);
            } else {
                cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil);
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 2) {
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
            if (_inputStickUtilityPresent) {
                cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_UTILITY_OPEN", InputStickStringTable, nil);
            } else {
                cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_MENU_TEXT_UTILITY_GET", InputStickStringTable, nil);
            }
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
    if (indexPath.section == 1) {
        if (_connectionState == InputStickDisconnected) {
            if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                if (indexPath.row == 0) {
                    //connect (last)
                    [self connectToMostRecentlyUsedDevice];
                } else if (indexPath.row == 1) {
                    // connect (discover)
                    if ([self.inputStickManager hasStoredDeviceIdentifier]) {
                        [self connectToManuallySelectedDevice];
                    } else {
                        [self showFirstConnectionInfoDialog];
                    }
                }
            } else {
                //connect (discover)
                [self connectToManuallySelectedDevice];
            }
        } else {
            //disconnect
            [self.inputStickManager disconnectFromInputStick];
        }
    } else if (indexPath.section == 2) {
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
                InputStickPreferences *prefs = [[InputStickPreferences alloc] init];
                [prefs loadFromUserDefaults];
                ((InputStickMacKeyboardSetupTableViewController *)vc).keyboardLayout = prefs.keyboardLayout;
                ((InputStickMacKeyboardSetupTableViewController *)vc).inputStickManager = self.inputStickManager;
                ((InputStickMacKeyboardSetupTableViewController *)vc).hideBarButton = self.hideBarButton;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } else if (indexPath.row == 3) {
            [self showAboutInputStickDialog];
        } else if (indexPath.row == 4) {
            if (_inputStickUtilityPresent) {
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickUtilityAppiTunesURL]];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL] options:@{} completionHandler:nil];
                                                              
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
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL] options:@{} completionHandler:nil];
                                                          }];
    [alertController addAction:webpageAction];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:dismissAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
