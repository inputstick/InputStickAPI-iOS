/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSNotificationCenter+Connection.h"
#import "ISConnectionManager.h"
#import "NSNotificationCenter+Helpers.h"

NSString *const ISConnectionManagerDidUpdatePeripheralsNotificationName = @"ISConnectionManagerDidUpdatePeripheralsNotification";
NSString *const ISWillStartConnectingPeripheralNotificationName = @"ISWillStartConnectingPeripheralNotification";
NSString *const ISDidFinishConnectingPeripheralNotificationName = @"ISDidFinishConnectingPeripheralNotification";
NSString *const ISDidFinishConnectingInputStickNotificationName = @"ISDidFinishConnectingInputStickNotification";
NSString *const ISDidDisconnectInputStickNotificationName = @"ISDidDisconnectInputStickNotification";

@implementation NSNotificationCenter (Connection)

#pragma mark - Post notifications

- (void)postDidUpdatePeripheralsListNotificationWithConnectionManager:(ISConnectionManager *)connectionManager {
    [self postNotificationName:ISConnectionManagerDidUpdatePeripheralsNotificationName
                        object:connectionManager
                      userInfo:@{@"peripheralsList" : [connectionManager.foundPeripherals copy]}];
}

- (void)postWillStartConnectingToPeripheralNotificationWithConnectionManager:(ISConnectionManager *)connectionManager {
    NSLog(@"Will start connecting");
    [self postNotificationName:ISWillStartConnectingPeripheralNotificationName
                        object:connectionManager];
}

- (void)postDidFinishConnectingToPeripheralNotificationWithConnectionManager:(ISConnectionManager *)connectionManager withError:(NSError *)error {
    NSLog(@"Did finish connecting%@", error ? [NSString stringWithFormat:@" with error: %@", error.description] : @"");
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"connectedPeripheral"] = connectionManager.connectedPeripheral;
    if (error) {
        userInfo[@"error"] = error;
    }
    [self postNotificationName:ISDidFinishConnectingPeripheralNotificationName
                        object:connectionManager
                      userInfo:[userInfo copy]];
}

- (void)postDidFinishConnectingInputStickNotificationWithConnectionManager:(ISConnectionManager *)connectionManager withError:(NSError *)error {
    [self postNotificationName:ISDidFinishConnectingInputStickNotificationName
                        object:connectionManager
                      userInfo:error ? @{@"error" : error} : nil];
}

- (void)postDidDisconnectInputStickNotificationWithConnectionManager:(ISConnectionManager *)connectionManager {
    [self postNotificationName:ISDidDisconnectInputStickNotificationName
                        object:connectionManager];
}

#pragma mark - Register and unregister notifications

- (void)registerForConnectionNotificationsWithObserver:(id <ConnectionNotificationObserver>)observer {
    [self addObserver:observer ifRespondsToSelector:@selector(didUpdatePeripheralsList:)
                 name:ISConnectionManagerDidUpdatePeripheralsNotificationName
               object:nil];

    [self addObserver:observer ifRespondsToSelector:@selector(willStartConnectingPeripheral:)
                 name:ISWillStartConnectingPeripheralNotificationName
               object:nil];

    [self addObserver:observer ifRespondsToSelector:@selector(didFinishConnectingPeripheral:)
                 name:ISDidFinishConnectingPeripheralNotificationName
               object:nil];

    [self addObserver:observer ifRespondsToSelector:@selector(didFinishConnectingInputStick:)
                 name:ISDidFinishConnectingInputStickNotificationName
               object:nil];

    [self addObserver:observer ifRespondsToSelector:@selector(didDisconnectInputStickNotification:)
                 name:ISDidDisconnectInputStickNotificationName
               object:nil];
}

- (void)unregisterFromConnectionNotificationsWithObserver:(id <ConnectionNotificationObserver>)observer {
    [self removeObserver:observer
                    name:ISConnectionManagerDidUpdatePeripheralsNotificationName
                  object:nil];

    [self removeObserver:observer
                    name:ISWillStartConnectingPeripheralNotificationName
                  object:nil];

    [self removeObserver:observer
                    name:ISDidFinishConnectingPeripheralNotificationName
                  object:nil];

    [self removeObserver:observer
                    name:ISDidFinishConnectingInputStickNotificationName
                  object:nil];

    [self removeObserver:observer
                    name:ISDidDisconnectInputStickNotificationName
                  object:nil];
}

@end
