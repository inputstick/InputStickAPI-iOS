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
 @brief requests to notify user that the device is no longer password protected (but it was last time)
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @discussion user should be notified that password protection was removed and connection will no longer be encrypted
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentKeyRemovedDialog:(InputStickDeviceData *)deviceData;

/*!
 @brief requests to notify user that the device is now password protected and he/she must provide password
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @param request type of password request (see InputStickManager)
 @discussion use updateDevicePassword method from InputStickManager to provide password
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request;

/*!
 @brief requests to notify user that there is new firmware available
 @param inputStickManager instance of InputStickManager
 @param deviceData stored device data of connected InputStick
 @discussion recommend user to use InputStickUtility app to flash latest available firmware. To disable or postopne update requests see InputStickDeviceData
 */
- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData;

@end
