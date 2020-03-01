/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickManager+Protected.h"
#import "InputStickConnectionManager.h"
#import "InputStickDeviceData.h"
#import "InputStickError.h"
#import "InputStickConst.h"


@implementation InputStickUI

+ (UIViewController *)topViewControllerForRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerForRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerForRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerForRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


#pragma mark - UIAlertControllers for InputStickManagerDelegate callbacks

+ (UIAlertController *)errorAlertDialog:(InputStickManager *)inputStickManager error:(NSError *)error {
    return [InputStickUI errorAlertDialog:inputStickManager error:error allowReconnecting:TRUE];
}

+ (UIAlertController *)errorAlertDialog:(InputStickManager *)inputStickManager error:(NSError *)error allowReconnecting:(BOOL)allowReconnecting {
    NSString *message = [NSString stringWithFormat:@"%@: %@ (0x%04lx)", NSLocalizedStringFromTable(@"INPUTSTICK", InputStickStringTable, nil), error.localizedDescription, (long)error.code];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_ERROR", InputStickStringTable, nil)
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (allowReconnecting) {
        if (error.code == INPUTSTICK_ERROR_BT_CONNECTION_LOST) {
            UIAlertAction *reconnectAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_RECONNECT", InputStickStringTable, nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action) {
                                                                     [inputStickManager connectToLastInputStick];
                                                                 }];
            [alertController addAction:reconnectAction];
        } else if (error.code == INPUTSTICK_ERROR_BT_CONNECTION_TIMEDOUT || error.code == INPUTSTICK_ERROR_BT_OUT_OF_RANGE) {
            UIAlertAction *retryAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_RETRY", InputStickStringTable, nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action) {
                                                                     [inputStickManager retryConnectionAttempt];
                                                                 }];
            [alertController addAction:retryAction];
        }
    }
    
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    
    return alertController;
}

+ (UIAlertController *)encryptionKeyAlertDialog:(InputStickManager *)inputStickManager deviceData:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    NSString *message;
    NSString *title;
    InputStickErrorCode errorCode;
    BOOL actionType = TRUE; //true -> verify key; false -> remove key
    switch (request) {
        case InputStickKeyRequestKeyRemoved:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_REMOVE_KEY", InputStickStringTable, nil);
            message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_REMOVE_KEY", InputStickStringTable, nil);
            errorCode = INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED;
            actionType = FALSE;
            break;
        case InputStickKeyRequestKeyMissing:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_PASSWORD_ACTION", InputStickStringTable, nil);
            message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_PASSWORD_REQUEST", InputStickStringTable, nil);
            errorCode = INPUTSTICK_ERROR_ENCRYPTION_NO_KEY;
            break;
        case InputStickKeyRequestKeyChanged:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_PASSWORD_ACTION", InputStickStringTable, nil);
            message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_PASSWORD_CHANGED", InputStickStringTable, nil);
            errorCode = INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY;
            break;
        case InputStickKeyRequestKeyInvalid:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_PASSWORD_ACTION", InputStickStringTable, nil);
            message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_PASSWORD_INVALID", InputStickStringTable, nil);
            errorCode = INPUTSTICK_ERROR_ENCRYPTION_INVALID_KEY;
            break;
    }

    if (actionType) {
        message = [message stringByAppendingString:@"\n\n"];
        message = [message stringByAppendingString:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_PASSWORD_HELP", InputStickStringTable, nil)];
    }
    

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionType) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {
                                                                 [inputStickManager disconnectWithErrorCode:errorCode];
                                                             }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             UITextField *textField = alertController.textFields.firstObject;
                                                             if ([textField.text length] > 0) {
                                                                 [inputStickManager updateDevicePassword:textField.text savePlainText:FALSE];
                                                             } else {
                                                                 [inputStickManager disconnectWithErrorCode:errorCode]; //same as cancel
                                                             }
                                                         }];
        

        
        UIAlertAction *helpAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_HELP", InputStickStringTable, nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageHelpURL] options:@{} completionHandler:nil];
                                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [alertController addAction:helpAction];
        
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
             textField.placeholder = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_PASSWORD", InputStickStringTable, nil);
             textField.secureTextEntry = YES;
             //[textField addTarget:self action:@selector(alertTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
         }];
    } else {
        UIAlertAction *disconnectAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISCONNECT", InputStickStringTable, nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action) {
                                                                     [inputStickManager disconnectWithErrorCode:INPUTSTICK_ERROR_ENCRYPTION_KEY_REMOVED];
                                                                 }];
        
        UIAlertAction *removeAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_BUTTON_REMOVE_KEY", InputStickStringTable, nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 [inputStickManager updateDevicePassword:nil savePlainText:FALSE];
                                                             }];
        
        [alertController addAction:removeAction];
        [alertController addAction:disconnectAction];
    }
    
    return alertController;
}

+ (UIAlertController *)firmwareUpdateAlertDialog:(InputStickManager *)inputStickManager deviceData:(InputStickDeviceData *)deviceData viewController:(UIViewController*)viewController {
    NSString *title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_FIRMWARE_UPDATE", InputStickStringTable, nil);
    NSString *message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_FIRMWARE_UPDATE", InputStickStringTable, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *postponeAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_BUTTON_UPDATE_POSTPONE", InputStickStringTable, nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               [deviceData postponeFirmwareUpdateReminderBy:(24*3600)]; //postpone next reminder by 24h
                                                           }];
    
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_BUTTON_UPDATE_SKIP", InputStickStringTable, nil)
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [deviceData disableFirmwareUpdateReminder];
                                                       }];
    
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_BUTTON_UPDATE_UPDATE", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [deviceData postponeFirmwareUpdateReminderBy:(24*3600)]; //postpone next reminder by 24h (in case firmware is not updated by user)
                                                             [inputStickManager disconnectWithErrorCode:INPUTSTICK_ERROR_NONE];
                                                             //launch/download InputStickUtility
                                                             NSURL *url = [NSURL URLWithString:[InputStickUtilityFirmwareUpdateURL stringByAppendingString:deviceData.identifier]];
                                                             BOOL result = [[UIApplication sharedApplication] openURL:url];
                                                             if ( !result) {
                                                                 UIAlertController *alertController = [InputStickUI downloadInputStickUtilityAlertDialog];
                                                                 [viewController presentViewController:alertController animated:YES completion:nil];
                                                             }                                                                                                                         
                                                         }];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISMISS", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    
    [alertController addAction:skipAction];
    [alertController addAction:postponeAction];
    [alertController addAction:updateAction];
    [alertController addAction:dismissAction];
    return alertController;
}

+ (UIAlertController *)downloadInputStickUtilityAlertDialog {
    NSString *title = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TITLE_INPUTSTICKUTILITY_DOWNLOAD", InputStickStringTable, nil);
    NSString *message = NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_TEXT_INPUTSTICKUTILITY_DOWNLOAD", InputStickStringTable, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_FIRMWARE_MANAGER_DIALOG_BUTTON_DOWNLOAD", InputStickStringTable, nil)
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickUtilityAppiTunesURL]];
                                                       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    
    [alertController addAction:downloadAction];
    [alertController addAction:cancelAction];
    return alertController;
}


#pragma mark - UIAlertControllers Helpers

+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message viewController:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)showErrorAlertWithMessage:(NSString *)message viewController:(UIViewController *)viewController {
    [InputStickUI showAlertWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_ERROR", InputStickStringTable, nil) withMessage:message viewController:viewController];
}

+ (void)showDisconnectDialog:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TITLE_DISCONNECT", InputStickStringTable, nil)
                                                                             message:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_DISCONNECT", InputStickStringTable, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *disconnectAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISCONNECT", InputStickStringTable, nil)
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction *action) {
                                                                 [inputStickManager disconnectFromInputStick];
                                                             }];
    [alertController addAction:disconnectAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Connection Status Helpers

+ (BOOL)checkIfBluetoothIsOn:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController {
    if (inputStickManager.bluetoothSupported) {
        if (inputStickManager.bluetoothOn) {
            return TRUE;
        } else {
            [InputStickUI showErrorAlertWithMessage:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_TURN_BT_ON", InputStickStringTable, nil) viewController:viewController];
            return FALSE;
        }
    } else {
        [InputStickUI showErrorAlertWithMessage:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_BT_NOT_SUPPORTED", InputStickStringTable, nil) viewController:viewController];
        return FALSE;
    }
}

+ (BOOL)checkIfInputStickIsReady:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController {
    if ([InputStickUI checkIfBluetoothIsOn:inputStickManager viewController:viewController]) {
        switch (inputStickManager.connectionState) {
            case InputStickDisconnected:
                [InputStickUI showNotConnectedErrorWithInputStickManager:inputStickManager viewController:viewController];
                return FALSE;
            case InputStickConnecting:
            case InputStickInitializing:
                [InputStickUI showErrorAlertWithMessage:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_CONNECTION_IN_PROGRESS", InputStickStringTable, nil) viewController:viewController];
                return FALSE;
            case InputStickWaitingForUSB:
                [InputStickUI showErrorAlertWithMessage:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_NOT_READY", InputStickStringTable, nil) viewController:viewController];
                return FALSE;
            case InputStickReady:
                return TRUE;
            default:
                return FALSE;
        }
    } else {
        //error message already displayed
        return FALSE;
    }
}

+ (void)showNotConnectedErrorWithInputStickManager:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController {
    BOOL canConnectLast = [inputStickManager hasStoredDeviceIdentifier];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_ERROR", InputStickStringTable, nil)
                                                                             message:NSLocalizedStringFromTable(@"INPUTSTICK_UTILS_DIALOG_TEXT_NOT_CONNECTED", InputStickStringTable, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (canConnectLast) {
        UIAlertAction *connectAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CONNECT_LAST", InputStickStringTable, nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [inputStickManager connectToLastInputStick];
                                                              }];
        [alertController addAction:connectAction];
    }
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_OK", InputStickStringTable, nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:dismissAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UI Helpers

+ (BOOL)isDarkThemeEnabled:(UIViewController *)viewController {
    BOOL darkTheme = FALSE;
    if (@available(iOS 13, *)) {
        darkTheme = (viewController.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
    }
    return darkTheme;
}

+ (NSString *)nameForInputStickConnectionState:(InputStickConnectionState)connectionState {
    switch (connectionState) {
        case InputStickDisconnected:
            return NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_DISCONNECTED", InputStickStringTable, nil);
        case InputStickConnecting:
            return NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_CONNECTING", InputStickStringTable, nil);
        case InputStickInitializing:
            return NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_INIT", InputStickStringTable, nil);
        case InputStickWaitingForUSB:
            return NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_USB_NOT_READY", InputStickStringTable, nil);
        case InputStickReady:
            return NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_READY", InputStickStringTable, nil);
        default:
            return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

+ (UIColor *)colorForInputStickConnectionState:(InputStickConnectionState)connectionState connectionError:(BOOL)connectionError {
    if (connectionError) {
        return [UIColor redColor];
    }
    
    switch (connectionState) {
        case InputStickDisconnected:
            if (@available(iOS 13, *)) {
                return [UIColor labelColor];
            } else {
                return [UIColor blackColor];
            }
        case InputStickConnecting:
        case InputStickInitializing:
            return [UIColor colorWithRed:247.f / 255.f green:152.f / 255.f blue: 98.f / 255.f alpha:1]; //~lt orange
        case InputStickWaitingForUSB:
            return [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1]; //~orange
        case InputStickReady:
            return [UIColor colorWithRed: 62.f / 255.f green:146.f / 255.f blue:241.f / 255.f alpha:1]; //~blue
        default:
            if (@available(iOS 13, *)) {
                return [UIColor labelColor];
            } else {
                return [UIColor blackColor];
            }
    }
}

@end
