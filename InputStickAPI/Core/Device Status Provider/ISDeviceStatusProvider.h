//
// Created by Marcin Wieclawski on 22/06/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISManager.h"
#import "NSNotificationCenter+Connection.h"

@class ISDeviceStatusProvider;
@class ISConnectionPacketFactory;

typedef NS_ENUM(NSInteger, ResponseParsingState) {
    ResponseStateTAG,
    ResponseStateLength,
    ResponseStateData
};

typedef NS_ENUM(NSInteger, ResponsePacketType) {
    ResponsePacketTypeUSBHIDStatusUpdate = 0x2F,
    ResponsePacketTypeRestoreDefaultsUpdate = 0x16,
    ResponsePacketTypeErrorNotification = 0x1F
};

@interface ISDeviceStatusProvider : NSObject <ConnectionNotificationObserver>
@property(nonatomic, weak, readonly) ISManager *manager;
@property(nonatomic) InputStickState inputStickState;

@property(nonatomic, strong) ISConnectionPacketFactory *connectionPacketFactory;

- (instancetype)initWithManager:(ISManager *)manager;

- (void)parseResponseBytes:(Byte *)responseBytes withLength:(NSUInteger)length;

@end
