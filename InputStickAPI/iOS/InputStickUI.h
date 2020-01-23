/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickUI.h
 @brief helpers that can be used to display InputStick-related dialogs
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, InputStickConnectionState);
typedef NS_ENUM(NSUInteger, InputStickKeyRequest);
@class InputStickManager;
@class InputStickDeviceData;

@interface InputStickUI : NSObject

+ (UIViewController *)topViewControllerForRootViewController:(UIViewController *)rootViewController;


#pragma mark - UIAlertControllers for InputStickManagerDelegate callbacks

/*!
 @brief UIAlertController informing user about error details
 @param error InputStick error
 @return UIAlertController with error details
 @discussion see InputStickError for details about possible error codes and messages
 */
+ (UIAlertController *)errorAlertDialog:(NSError *)error;

/*!
 @brief UIAlertController requesting user to provide password for InputStick or informing that encryption key was removed
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @param request type of password request (see InputStickManager)
 @discussion depending on request type user can provide password (used to generate encryption key) or is informed that encryption key was removed (InputStick is no longer password protected)
 */
+ (UIAlertController *)encryptionKeyAlertDialog:(InputStickManager *)inputStickManager deviceData:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request;

/*!
 @brief UIAlertController informing user that there is a newer firmware version available
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @param viewController if InputStickUtility app is not installed, this viewController will be used to present AlertDialog asking user whether to download the app
 @discussion user can choose to open InputStickUtility app to update firmware, postpone update reminder or disable update reminders. if InputStickUtility app is not installed, another dialog will be displayed, asking user whether to download InputStickUtility app
 */
+ (UIAlertController *)firmwareUpdateAlertDialog:(InputStickManager *)inputStickManager deviceData:(InputStickDeviceData *)deviceData viewController:(UIViewController*)viewController;

/*!
 @brief UIAlertController asking user whether to download InputStickUtility app form iTunes
 @return UIAlertController asking user whether to download InputStickUtility app
 */
+ (UIAlertController *)downloadInputStickUtilityAlertDialog;


#pragma mark - UIAlertControllers Helpers

/*!
 @brief shows UIAlertController with provided parameters
 @param title title for UIAlertController
 @param message message for UIAlertController
 @param viewController ViewController used to display alert
 */
+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message viewController:(UIViewController *)viewController;

/*!
 @brief shows UIAlertController with error message
 @param message message for UIAlertController
 @param viewController ViewController used to display alert
 */
+ (void)showErrorAlertWithMessage:(NSString *)message viewController:(UIViewController *)viewController;

/*!
 @brief shows UIAlertController asking if user wants to disconnect from InputStick
 @param inputStickManager instance of InputStickManager
 @param viewController ViewController used to display alert
 @discussion user can disconnect or dismiss the message without disconnecting
 */
+ (void)showDisconnectDialog:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController;


#pragma mark - Connection Status Helpers

/*!
 @brief checks if Bluetooth is turned on, shows error message if it is turned off
 @param inputStickManager instance of InputStickManager
 @param viewController ViewController used to display error message
 @return TRUE if Bluetooth is turned on
 @discussion if Bluetooth is turned off, FALSE is returned and UIAlertController with an error message will be presented from provided ViewController
 */
+ (BOOL)checkIfBluetoothIsOn:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController;

/*!
 @brief checks if InputStick is ready to send HID actions, shows error message if not
 @param inputStickManager instance of InputStickManager
 @param viewController ViewController used to display error message
 @return TRUE if InputStick is ready to send HID actions
 @discussion if InputStick is not ready, FALSE is returned and UIAlertController with an error message will be presented from provided ViewController
 */
+ (BOOL)checkIfInputStickIsReady:(InputStickManager *)inputStickManager viewController:(UIViewController *)viewController;


#pragma mark - UI Helpers

/*!
@brief checks if system dark theme is currently enabled
@param viewController current UIViewController
@return TRUE if dark theme is enabled
*/
+ (BOOL)isDarkThemeEnabled:(UIViewController *)viewController;

/*!
 @brief text representation of provided connection state
 @return text representation of provided connection state
 */
+ (NSString *)nameForInputStickConnectionState:(InputStickConnectionState)connectionState;

/*!
 @brief color representing provided connection state
 @return color representing provided connection state
 */
+ (UIColor *)colorForInputStickConnectionState:(InputStickConnectionState)connectionState;

@end
