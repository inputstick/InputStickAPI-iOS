/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISManager.h"
#import "ISManagerDelegate.h"
#import "NSNotificationCenter+Connection.h"
#import "ISConnectionManager.h"
#import "ISDeviceSelectionViewControllerProtocol.h"
#import "ISDeviceSelectionViewController.h"
#import "ISBluetoothBuffer.h"


@implementation ISManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.blueToothBuffer = [[ISBlueToothBuffer alloc] initWithManager:self];
        self.deviceStatusProvider = [[ISDeviceStatusProvider alloc] initWithManager:self];
        self.connectionManager = [[ISConnectionManager alloc] initWithManager:self
                                                         deviceStatusProvider:self.deviceStatusProvider];
    }
    return self;
}

#pragma mark - Input stick Connection

- (void)connectToInputStickUsingStoredIdentifier:(BOOL)useStoredIdentifier {
    [self.blueToothBuffer clearQueues];
    if (useStoredIdentifier && [ISConnectionManager inputStickDeviceIdentifier]) {
        [self.connectionManager connectToPeripheralWithIdentifier:[ISConnectionManager inputStickDeviceIdentifier]];
    }
    else {
        UIViewController <ISDeviceSelectionViewControllerProtocol> *viewController;
        if ([self.delegate respondsToSelector:@selector(selectionViewControllerForConnectionManager:withInputStickManager:)]) {
            viewController = [self.delegate selectionViewControllerForConnectionManager:self.connectionManager
                                                                  withInputStickManager:self];
        } else {
            viewController = [[ISDeviceSelectionViewController alloc] initWithConnectionManager:self.connectionManager];
        }
        [self.delegate inputStickManager:self
                   presentViewController:viewController];
    }
}

- (void)disconnectInputStickDevice {
    [self.connectionManager disconnectCurrentDevice];
}

- (BOOL)isReady {
    return self.inputStickState == InputStickStateReady;
}

#pragma mark - Send Data

- (void)sendData:(NSData *)data {
    if (![self connectedPeripheral] || ![self discoveredCharacteristic]) {
        NSLog(@"Attempted to send data without an active connection to Input Stick device");
        return;
    }
    [[self connectedPeripheral] writeValue:data
                         forCharacteristic:[self discoveredCharacteristic]
                                      type:CBCharacteristicWriteWithoutResponse];
}

#pragma mark - Getter overrides

- (InputStickState)inputStickState {
    return self.deviceStatusProvider.inputStickState;
}

#pragma mark - Helpers

- (CBPeripheral *)connectedPeripheral {
    return self.connectionManager.connectedPeripheral;
}

- (CBCharacteristic *)discoveredCharacteristic {
    return self.connectionManager.discoveredCharacteristic;
}

@end
