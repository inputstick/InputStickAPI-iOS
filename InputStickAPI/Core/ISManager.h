//
// Created by Marcin Wieclawski on 06/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNotificationCenter+Connection.h"

@class ISConnectionManager;
@class ISDeviceSelectionViewController;
@class ISBlueToothBuffer;
@class ISDeviceStatusProvider;
@class ISConnectionPacketFactory;
@protocol ISManagerDelegate;

typedef NS_ENUM(NSInteger, InputStickState) {
    InputStickStateDisconnected,
    InputStickStateConnecting,      //Waiting for connection
    InputStickStateInit,            //Communicating with the device, verifying firmware version and settings
    InputStickStateWaitingForUSB,   //waiting for confirmation, that USB is ready
    InputStickStateReady            //ready to send HID reports
};

@interface ISManager : NSObject <ConnectionNotificationObserver>
@property(nonatomic, assign) id <ISManagerDelegate> delegate;
@property(nonatomic, readonly) ISConnectionManager *connectionManager;
@property(nonatomic, readonly) InputStickState inputStickState;
@property(nonatomic, readonly) ISBlueToothBuffer *blueToothBuffer;
@property(nonatomic, readonly) ISDeviceStatusProvider *deviceStatusProvider;
@property(nonatomic, strong) ISConnectionPacketFactory *connectionPacketFactory;

#pragma mark - Connection management

- (void)connectToInputStickUsingStoredIdentifier:(BOOL)useStoredIdentifier;

- (void)disconnectInputStickDevice;

- (BOOL)isReady;

#pragma mark - Send Data

- (void)sendData:(NSData *)data;

- (void)sendRunFirmwarePacket;

@end
