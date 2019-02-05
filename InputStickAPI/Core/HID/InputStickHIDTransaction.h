/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickHIDTransaction.h
 @brief allows to store multiple HID reports, that (if possible) will be sent in a single packet
 @discussion all HID reports in a transaction must be of the same type (keyboard, mouse etc.)
 Transaction will be splitted if it contains more reports that can be sent in a single packet
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(Byte, InputStickCmd);
@class InputStickHIDReport;

@interface InputStickHIDTransaction : NSObject

/*! command that will be used when sending HID reports from this transaction */
@property(nonatomic, readonly) InputStickCmd packetCmd;
/*! stores HID reports */
@property(readonly) NSMutableArray<InputStickHIDReport*> *reports;

/*! TRUE when there is at least one more HID report stored */
@property(nonatomic, readonly) BOOL hasNext;
/*! number of stored HID reports */
@property(nonatomic, readonly) NSUInteger reportsCount;


#pragma mark - Object lifecycle

/*!
 @brief initializes InputStickHIDTransaction
 @param cmd InputStickCmd that will be used to send reports to InputStick
 @return InputStickHIDTransaction
 @discussion all reports added to this transaction must be of the same type (use the same command)
 */
- (instancetype)initWithCmd:(InputStickCmd)cmd;


#pragma mark - Class Initializers

/*!
 @brief initializes InputStickHIDTransaction for storing keyboard HID reports (2B format)
 @return InputStickHIDTransaction
 */
+ (instancetype)shortKeyboardTransaction;

/*!
 @brief initializes InputStickHIDTransaction for storing keyboard HID reports (8B format)
 @return InputStickHIDTransaction
 */
+ (instancetype)keyboardTransaction;

/*!
 @brief initializes InputStickHIDTransaction for storing mouse HID reports
 @return InputStickHIDTransaction
 */
+ (instancetype)mouseTransaction;

/*!
 @brief initializes InputStickHIDTransaction for storing consumer control HID reports
 @return InputStickHIDTransaction
 */
+ (instancetype)consumerTransaction;

/*!
 @brief initializes InputStickHIDTransaction for storing gamepad HID reports
 @return InputStickHIDTransaction
 */
+ (instancetype)gamepadTransaction;

/*!
 @brief initializes InputStickHIDTransaction for storing touch-screen HID reports
 @return InputStickHIDTransaction
 */
+ (instancetype)touchScreenTransaction;


/*!
 @brief adds report to the transacion
 @param report HID report to add
 */
- (void)addHIDReport:(InputStickHIDReport *)report;

/*!
 @brief removes first HID report from the transaction
 @return first HID report
 */
- (InputStickHIDReport *)pollReport;

/*!
 @brief splits the transaction by removing specified number of HID reports
 @param count number of HID reports to remove from this transaction
 @return InputStickHIDTransaction containing first count reports
 */
- (InputStickHIDTransaction *)splitBy:(NSUInteger)count;


@end
