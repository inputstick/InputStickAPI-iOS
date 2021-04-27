/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>
#import "InputStickManager.h"

@class InputStickDeviceData;

@protocol InputStickManagerDelegate <NSObject>

/*!
 @brief requests to notify user about InputStick-related error
 @param inputStickManager instance of InputStickManager
 @param error error that occured
 @discussion see InputStickError for details about possible error codes and messages
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error;

/*!
 @brief requests to notify user that encryption key-related action is necessary
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @param request type of password request (see InputStickManager)
 @return return TRUE if dialog was diaplayed, if it is not possible to display dialog, return FALSE to disconnect with error
 @discussion depending on request type user must confirm that encryption key was removed or provide new encryption key
 */
- (BOOL)inputStickManager:(InputStickManager *)inputStickManager presentEncryptionKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request;

/*!
 @brief requests to notify user that there is new firmware available
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @discussion recommend user to use InputStickUtility app to flash latest available firmware. To disable or postopne update requests see InputStickDeviceData
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData;

/*!
 @brief requests to notify user that USB is suspended
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @discussion user can disconnect or request to resume USB (wake up host) 
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentUSBResumeDialog:(InputStickDeviceData *)deviceData;

@end
