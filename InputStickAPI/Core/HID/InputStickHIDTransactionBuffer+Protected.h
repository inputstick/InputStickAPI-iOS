/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @brief contains methods/fields used internally by InputStick API
 */

#import <Foundation/Foundation.h>


@interface InputStickHIDTransactionBuffer (Protected)

#pragma mark - Setup & State Update

- (void)setupWithCapacity:(NSUInteger)capacity maxReportsPerPacket:(NSUInteger)maxReports;

- (void)updateWithNumberOfReportsSentToHost:(NSUInteger)reportsCount isEmpty:(BOOL)isEmpty;

@end
