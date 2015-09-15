//
// Created by Marcin Wieclawski on 06/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISConnectionManager;
@class ISDeviceSelectionViewController;
@class ISBlueToothBuffer;
@class ISDeviceStatusProvider;
@protocol ISManagerDelegate;

typedef NS_ENUM(NSInteger, InputStickState) {
    InputStickStateDisconnected,
    InputStickStateConnecting,      //Waiting for connection
    InputStickStateInit,            //Communicating with the device, verifying firmware version and settings
    InputStickStateWaitingForUSB,   //waiting for confirmation, that USB is ready
    InputStickStateReady            //ready to send HID reports
};

@interface ISManager : NSObject
@property(nonatomic, strong) ISConnectionManager *connectionManager;
@property(nonatomic, assign) id <ISManagerDelegate> delegate;
@property(nonatomic, readonly) InputStickState inputStickState;

@property(nonatomic, strong) ISBlueToothBuffer *blueToothBuffer;
@property(nonatomic, strong) ISDeviceStatusProvider *deviceStatusProvider;

#pragma mark - Connection management

- (void)connectToInputStickUsingStoredIdentifier:(BOOL)useStoredIdentifier;

- (void)disconnectInputStickDevice;

- (BOOL)isReady;

- (void)sendData:(NSData *)data;

@end
