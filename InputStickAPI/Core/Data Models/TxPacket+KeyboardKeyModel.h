//
// Created by Marcin Wieclawski on 22/08/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TxPacket.h"

@class ISKeyboardKeyModel;
@class ISKeyboardReport;

@interface TxPacket (KeyboardKeyModel)

- (void)addBytesFromKeyboardKeyModel:(ISKeyboardKeyModel *)model;

- (void)addBytesFromKeyboardReport:(ISKeyboardReport *)keyboardReport;

@end
