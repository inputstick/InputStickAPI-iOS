//
// Created by Marcin Wieclawski on 12/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ISConnectionManagerDidUpdatePeripheralsNotificationName;
extern NSString *const ISWillStartConnectingPeripheralNotificationName;
extern NSString *const ISDidFinishConnectingPeripheralNotificationName;
extern NSString *const ISDidFinishConnectingInputStickNotificationName;
extern NSString *const ISDidDisconnectInputStickNotificationName;

@class ISConnectionManager;

@protocol ConnectionNotificationObserver
@optional
- (void)didUpdatePeripheralsList:(NSNotification *)notification;

- (void)willStartConnectingPeripheral:(NSNotification *)notification;

- (void)didFinishConnectingPeripheral:(NSNotification *)notification;

- (void)didFinishConnectingInputStick:(NSNotification *)notification;

- (void)didDisconnectInputStickNotification:(NSNotification *)notification;

@end

@interface NSNotificationCenter (Connection)

#pragma mark - Post Notifications

- (void)postDidUpdatePeripheralsListNotificationWithConnectionManager:(ISConnectionManager *)connectionManager;

- (void)postWillStartConnectingToPeripheralNotificationWithConnectionManager:(ISConnectionManager *)connectionManager;

- (void)postDidFinishConnectingToPeripheralNotificationWithConnectionManager:(ISConnectionManager *)connectionManager withError:(NSError *)error;

- (void)postDidFinishConnectingInputStickNotificationWithConnectionManager:(ISConnectionManager *)connectionManager withError:(NSError *)error;

- (void)postDidDisconnectInputStickNotificationWithConnectionManager:(ISConnectionManager *)connectionManager;

#pragma mark - Register and Unregister

- (void)registerForConnectionNotificationsWithObserver:(id <ConnectionNotificationObserver>)observer;

- (void)unregisterFromConnectionNotificationsWithObserver:(id <ConnectionNotificationObserver>)observer;

@end
