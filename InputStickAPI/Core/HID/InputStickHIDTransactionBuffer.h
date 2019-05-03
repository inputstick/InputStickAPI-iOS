/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickHIDTransactionBuffer.h
 @brief local HID buffer used for queuing HID reports (as HID transactions)
 @discussion HID transaction consists of one or more HID reports.
 If possible, all reports from a transaction will be sent in a single packet
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, InputStickHIDInterface);
@class InputStickManager;
@class InputStickHIDReport;
@class InputStickHIDTransaction;

@interface InputStickHIDTransactionBuffer : NSObject

@property(nonatomic, weak, readonly) InputStickManager *manager;
@property(readonly) NSMutableArray<InputStickHIDTransaction*> *queue; 
@property(readonly) NSUInteger freeSpace;
@property(readonly) NSUInteger capacity;
@property(readonly) NSUInteger maxReportsPerPacket;

@property (nonatomic, readonly) BOOL bufferEmpty;
@property (nonatomic, readonly) BOOL localBufferEmpty;

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager withHIDInterface:(InputStickHIDInterface)interface;


#pragma mark - Queue

- (void)flush;

- (void)addHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush;

- (void)addHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush;

- (void)clear;

@end
