/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickDeviceManagementTableViewController.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickConst.h"
#import "InputStickUI.h"

static NSString *const CellReuseIdentifier = @"InputStickDeviceManagementCellIdentifier";


@interface InputStickDeviceManagementTableViewController () {
    InputStickManager *_manager;
    BOOL _storeAfterEditing;
}

@end


@implementation InputStickDeviceManagementTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _manager = manager;        
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TITLE", InputStickStringTable, nil);
    //do not registerClass forCellReuseIdentifier! we need UITableViewCellStyleSubtitle! see cellForRowAtIndexPath
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [InputStickTheme themeViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSMutableArray<InputStickDeviceData *> *tmp = [_manager.deviceDB deviceDbArray];
    if ([tmp count] > 0) {
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 2;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_NO_SAVED_DEVICES", InputStickStringTable, nil);
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TABLE_SECTION_MY_DEVICES", InputStickStringTable, nil);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_FOOTER_INPUTSTICKUTILITY", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_FOOTER_STATUS_REFRESH_INFO", InputStickStringTable, nil);
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [[_manager.deviceDB deviceDbArray] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [InputStickTheme themeTableViewCell:cell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_OPEN_INPUTSTICKUTILITY", InputStickStringTable, nil);
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellReuseIdentifier];
            [InputStickTheme themeTableViewCell:cell];
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
        
        InputStickDeviceData *deviceData = [[_manager.deviceDB deviceDbArray] objectAtIndex:indexPath.row];
        [self updateDeviceInfoCell:cell withDeviceData:deviceData];
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self inputStickUtilityAction];
    }
    if (indexPath.section == 1) {
        InputStickDeviceData *deviceData = [[_manager.deviceDB deviceDbArray] objectAtIndex:indexPath.row];
        [self showMenuForDevice:deviceData atIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        InputStickDeviceData *deviceData = [[_manager.deviceDB deviceDbArray] objectAtIndex:indexPath.row];
        [self showMenuForDevice:deviceData atIndexPath:indexPath];
    }
}


#pragma mark - TableView Editing

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            InputStickDeviceData *deviceData = [[_manager.deviceDB deviceDbArray] objectAtIndex:indexPath.row];
            [self showDeleteDialogForDevice:deviceData atIndexPath:indexPath];
        }
    }
}

- (void)deleteDeviceAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [_manager.deviceDB deleteDeviceWithIndex:indexPath.row];
        _storeAfterEditing = FALSE;
        
        NSMutableArray<InputStickDeviceData *> *tmp = [_manager.deviceDB deviceDbArray];
        if ([tmp count] == 0) {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            [self setEditing:FALSE]; //since there are 0 sections now
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [_manager.deviceDB swapDeviceFromIndex:fromIndexPath.row toIndex:toIndexPath.row updateDatabase:FALSE];
    _storeAfterEditing = TRUE;
    //setEditing will update order & save changes
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        _storeAfterEditing = FALSE;
    } else {
        if (_storeAfterEditing) {
            [_manager.deviceDB storeDatabase];
            _storeAfterEditing = FALSE;
        }
    }
}


#pragma mark - UI

- (void)inputStickUtilityAction {
    /* IMPORTANT:
     <key>LSApplicationQueriesSchemes</key>
     <array>
         <string>inputstickutility</string>
     </array>
     must be added to Info.plist file!
     */
    NSURL *url = [NSURL URLWithString:InputStickUtilityLaunchURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        UIAlertController *alertController = [InputStickUI downloadInputStickUtilityAlertDialog];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)updateDeviceInfoCell:(UITableViewCell *)cell withDeviceData:(InputStickDeviceData *)deviceData {
    NSString *subtitle = @"";
    //security info
    switch (deviceData.passwordProtectionStatus) {
        case PasswordProtectionEnabledOK:
            break;
        case PasswordProtectionEnabledInvalidKey:
        case PasswordProtectionEnabledNoKey:
        case PasswordProtectionDisabledHasKey:
            subtitle = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_TIP_PASSWORD_ISSUE", InputStickStringTable, nil);
            break;
        case PasswordProtectionDisabledOK:
            subtitle = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_TIP_SET_PASSWORD", InputStickStringTable, nil);
            break;
    }
    //firmware info
    if ( ![deviceData hasLatestFirmware]) {
        if (subtitle.length > 0) {
            subtitle = [subtitle stringByAppendingString:@" "];
        }
        subtitle = [subtitle stringByAppendingString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_TIP_FW_UPDATE", InputStickStringTable, nil)];
    }
    //tap for more info
    if (subtitle.length > 0) {
        subtitle = [subtitle stringByAppendingString:@" "];
        subtitle = [subtitle stringByAppendingString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_TIP_MORE_INFO", InputStickStringTable, nil)];
    }
    
    cell.textLabel.text = deviceData.name;
    cell.detailTextLabel.text = subtitle;
}


#pragma mark - Dialogs

- (void)showMenuForDevice:(InputStickDeviceData *)deviceData atIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:deviceData.name
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *showDetailsAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_BUTTON_DETAILS", InputStickStringTable, nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [self showDetailsDialogForDevice:deviceData atIndexPath:indexPath];
                                                              }];
    [alertController addAction:showDetailsAction];
    
    UIAlertAction *renameAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_BUTTON_RENAME", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self showRenameDialogForDevice:deviceData];
                                                         }];
    [alertController addAction:renameAction];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_BUTTON_DELETE", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             [self showDeleteDialogForDevice:deviceData atIndexPath:indexPath];
                                                         }];
    [alertController addAction:deleteAction];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:dismissAction];
    
    //required for iPad:
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    alertController.popoverPresentationController.sourceView = cell.contentView;
    alertController.popoverPresentationController.sourceRect = cell.contentView.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showRenameDialogForDevice:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TITLE_RENAME", InputStickStringTable, nil)
                                                                             message:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TEXT_RENAME", InputStickStringTable, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TEXT_NEW_NAME", InputStickStringTable, nil);
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              NSString *name = [[alertController textFields][0]text];
                                                              if (name.length > 0) {
                                                                  [deviceData setName:name];
                                                                  [self.tableView reloadData];
                                                              }
                                                          }];
    [alertController addAction:confirmAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showDetailsDialogForDevice:(InputStickDeviceData *)deviceData atIndexPath:(NSIndexPath *)indexPath {
    NSMutableAttributedString *msg = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *tmp;
    
    //name
    tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_NAME", InputStickStringTable, nil)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@": "];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:deviceData.name];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [msg appendAttributedString:tmp];
    
    //BT ID
    tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_BT_ID", InputStickStringTable, nil)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@": "];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:deviceData.identifier];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [msg appendAttributedString:tmp];    
    
    //firmware version
    tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_FW_VERSION", InputStickStringTable, nil)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@": "];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:[deviceData firmwareVersionString]];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [msg appendAttributedString:tmp];
    
    if ( ![deviceData hasLatestFirmware]) {
        tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_FW_UPDATE_RECOMMENDATION", InputStickStringTable, nil)];
        [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
        [tmp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, tmp.length)];
        [msg appendAttributedString:tmp];
        tmp = [[NSMutableAttributedString alloc] initWithString:@"\n"];
        [msg appendAttributedString:tmp];
    }
    
    //security (password protection status)
    tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_TEXT_SECURITY", InputStickStringTable, nil)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    tmp = [[NSMutableAttributedString alloc] initWithString:@": "];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];
    
    switch (deviceData.passwordProtectionStatus) {
        case PasswordProtectionEnabledOK:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_SECURITY_TEXT_STATUS_ENABLED_OK", InputStickStringTable, nil)];
            break;
        case PasswordProtectionEnabledNoKey:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_SECURITY_TEXT_STATUS_ENABLED_NO_KEY", InputStickStringTable, nil)];
            [tmp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,  tmp.length)];
            break;
        case PasswordProtectionEnabledInvalidKey:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_SECURITY_TEXT_STATUS_ENABLED_INVALID_KEY", InputStickStringTable, nil)];
            [tmp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,  tmp.length)];
            break;
        case PasswordProtectionDisabledOK:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_SECURITY_TEXT_STATUS_DISABLED_OK", InputStickStringTable, nil)];
            break;
        case PasswordProtectionDisabledHasKey:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_SECURITY_TEXT_STATUS_DISABLED_HAS_KEY", InputStickStringTable, nil)];
            [tmp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,  tmp.length)];
            break;
        default:
            tmp = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil)];
            break;
    }
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, tmp.length)];
    [msg appendAttributedString:tmp];

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TITLE_DETAILS", InputStickStringTable, nil)
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    
    [alertController setValue:msg forKey:@"attributedMessage"];
    
    //required for iPad:
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    alertController.popoverPresentationController.sourceView = cell.contentView;
    alertController.popoverPresentationController.sourceRect = cell.contentView.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showDeleteDialogForDevice:(InputStickDeviceData *)deviceData atIndexPath:(NSIndexPath *)indexPath {
    NSString *title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TEXT_DELETE", InputStickStringTable, nil);
    title = [title stringByReplacingOccurrencesOfString:@"%p" withString:deviceData.name];
    NSString *message = nil;
    if (deviceData.key != nil) {
        message = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_TEXT_DELETE_KEY_WARNING", InputStickStringTable, nil);
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_MANAGEMENT_DIALOG_BUTTON_DELETE", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             [self deleteDeviceAtIndexPath:indexPath];                                                             
                                                         }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    
    //required for iPad:
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    alertController.popoverPresentationController.sourceView = cell.contentView;
    alertController.popoverPresentationController.sourceRect = cell.contentView.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
