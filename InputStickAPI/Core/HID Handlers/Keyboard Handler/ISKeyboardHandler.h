//
// Created by Marcin Wieclawski on 26/07/15.
// Copyright (c) 2015 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNotificationCenter+DeviceStatus.h"
#import "ISHIDHandler.h"

@class ISKeyboardLedsState;
@class ISManager;
@protocol ISKeyboardLayoutProtocol;

@interface ISKeyboardHandler : NSObject <ISHIDHandler, ResponseParsingNotificationObserver>
@property(nonatomic, readonly) BOOL numLockOn;
@property(nonatomic, readonly) BOOL capsLockOn;
@property(nonatomic, readonly) BOOL scrollLockOn;

- (instancetype)initWithInputStickManager:(ISManager *)inputStickManager;

#pragma mark - Custom Report

- (void)sendCustomReportWithModifier:(Byte)modifier key:(Byte)key sendASAP:(BOOL)sendASAP;

#pragma mark - Press and release

- (void)pressKeyAndReleaseWithModifier:(Byte)modifier key:(Byte)key multiplier:(NSInteger)multiplier sendASAP:(BOOL)sendASAP;

- (void)sendText:(NSString *)text;

- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout;

- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout multiplier:(NSInteger)multiplier;

@end
