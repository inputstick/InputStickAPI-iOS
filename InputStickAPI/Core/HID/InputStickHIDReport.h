/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickHIDReport.h
 @brief HID report represents state/change of state of particular HID Interface
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(Byte, InputStickCmd);


@interface InputStickHIDReport : NSObject

/*! raw HID report data bytes */
@property(nonatomic, readonly) Byte *bytes;
/*! number of bytes */
@property(nonatomic, readonly) NSUInteger length;
/*! command that will be used when sending the report to InputStick */
@property(nonatomic, readonly) InputStickCmd packetCmd;


#pragma mark - Object lifecycle

/*!
 @brief initializes InputStickHIDReport
 @param cmd InputStickCmd that will be used to send reports to InputStick
 @return InputStickHIDTransaction
 @discussion all reports added to this transaction must be of the same type (use the same command)
 */
- (instancetype)initWithBytes:(Byte *)bytes withLength:(NSUInteger)length withCmd:(InputStickCmd)cmd;


#pragma mark - Class Initializers

/*!
 @brief initializes HID Keyboard Report (full 8B format)
 @return InputStickHIDTransaction
 @discussion bytes: modifiers, reserved (always 0x00), key0, key1, key2, key3, key4, key5
 */
+ (instancetype)keyboardReportWithBytes:(Byte[8])bytes;

/*!
 @brief initializes HID Keyboard Report (short 2B format)
 @return InputStickHIDTransaction
 @discussion bytes: modifiers, key
 */
+ (instancetype)shortKeyboardReportWithBytes:(Byte[2])bytes;

/*!
 @brief initializes HID Mouse Report
 @return InputStickHIDTransaction
 @discussion bytes: buttons, dx, dy, scroll
 */
+ (instancetype)mouseReportWithBytes:(Byte[4])bytes;

/*!
 @brief initializes HID Consumer Control Report
 @return InputStickHIDTransaction
 @discussion bytes: reportID, usage_lsb, usage_msb
 */
+ (instancetype)consumerReportWithBytes:(Byte[3])bytes;

/*!
 @brief initializes HID Gamepad report
 @return InputStickHIDTransaction
 @discussion bytes: reportID, buttons1, buttons2, x, y, z, rX
 */
+ (instancetype)gamepadReportWithBytes:(Byte[7])bytes;

/*!
 @brief initializes HID Touch Screen report
 @return InputStickHIDTransaction
 @discussion bytes: reportID, button(tip switch)+in_range, x_lsb, x_msb, y_lsb, y_msb
 */
+ (instancetype)touchScreenReportWithBytes:(Byte[6])bytes;

@end
