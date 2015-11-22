//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISHIDHandler.h"

@class ISManager;

extern const Byte MOUSE_BUTTON_NONE;
extern const Byte MOUSE_BUTTON_LEFT;
extern const Byte MOUSE_BUTTON_RIGHT;
extern const Byte MOUSE_BUTTON_MIDDLE;

@interface ISMouseHandler : NSObject<ISHIDHandler>

- (instancetype)initWithInputStickManager:(ISManager *)manager;

#pragma mark - Custom Report

- (void)sendCustomReportWithButtons:(Byte)buttons x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)scroll sendASAP:(BOOL)sendASAP;

#pragma mark - Mouse actions

- (void)sendMoveToX:(SignedByte)x y:(SignedByte)y;

- (void)sendScroll:(SignedByte)scrollValue;

- (void)sendPressedButtons:(Byte)buttons numberOfPress:(NSInteger)numberOfPresses multiplier:(NSInteger)multiplier;

@end
