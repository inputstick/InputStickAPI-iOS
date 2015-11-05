//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISHIDHandler.h"

@class ISManager;

extern const Byte SYSTEM_REPORT_ID;
extern const Byte CONSUMER_REPORT_ID;

typedef NS_ENUM(NSInteger, ISConsumerActions) {
    ConsumerActionVolumeUp = 0x00E9,
    ConsumerActionVolumeDown = 0x00EA,
    ConsumerActionVolumeMute = 0x00E2,
    ConsumerActionTrackNext = 0x00B5,
    ConsumerActionTrackPrevious = 0x00B6,
    ConsumerActionStop = 0x00B7,
    ConsumerActionPlayPouse = 0x00CD,
    ConsumerActionLaunchBrowser = 0x0196,
    ConsumerActionLaunchEmail = 0x018A,
    ConsumerActionLaunchCalc = 0x0192
};

typedef NS_ENUM(Byte, ISSystemActions) {
    SystemActionPowerDown = 0x01,
    SystemActionSleep = 0x02,
    SystemActionWakeup = 0x03
};

@interface ISConsumerHandler : NSObject <ISHIDHandler>

- (instancetype)initWithManager:(ISManager *)manager;

#pragma mark - Custom Report

- (void)sendCustomReportWithId:(Byte)reportId withLSBUsage:(Byte)lsbUsage withMSBUsage:(Byte)msbUsage sendASAP:(BOOL)sendASAP;

#pragma mark - Consumer actions

- (void)consumerActionWithUsage:(ISConsumerActions)usage;

- (void)systemActionWithUsage:(ISSystemActions)usage;

@end
