//
// Created by Marcin Wieclawski on 24/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TxPacket.h"

@class ISReport;

@interface TxPacket (Report)
- (void)addBytesFromReport:(ISReport *)report;

@end
