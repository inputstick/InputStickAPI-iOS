//
// Created by Marcin Wieclawski on 22/06/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNotificationCenter+DeviceStatus.h"

@class TxPacket;
@class ISManager;
@class ISKeyboardKeyModel;
@class ISReport;

@interface ISBlueToothBuffer : NSObject <ResponseParsingNotificationObserver>
@property(nonatomic, weak, readonly) ISManager *manager;

@property(nonatomic, readonly) NSMutableArray *keyboardReportsQueue;
@property(nonatomic, readonly) NSMutableArray *mouseReportQueue;

@property(nonatomic, readonly) NSInteger freeSpaceKeyboard;
@property(nonatomic, readonly) NSInteger freeSpaceMouse;

#pragma mark - Object lifecycle

- (instancetype)initWithManager:(ISManager *)manager;

#pragma mark - Keyboard

- (void)addKeyboardReportToQueue:(ISReport *)keyboardReport sendASAP:(BOOL)sendASAP;

- (void)addKeyboardKeyModelToQueue:(ISKeyboardKeyModel *)keyboardKeyModel sendASAP:(BOOL)sendASAP;

- (void)sendKeyboard;

#pragma mark - Mouse

-(void)addMouseReportToQueue:(ISReport *)mouseReport sendASAP:(BOOL)sendASAP;

-(void)sendMouse;

#pragma mark - Consumer

- (void)addConsumerReportToQueue:(ISReport *)report sendASAP:(BOOL)sendASAP;

- (void)sendConsumer;

- (void)sendGamepadReport:(ISReport *)gamepadReport;

#pragma mark - Helpers

- (void)clearQueues;

@end
