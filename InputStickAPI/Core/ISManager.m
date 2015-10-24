/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISManager.h"
#import "ISManagerDelegate.h"
#import "NSNotificationCenter+Connection.h"
#import "ISConnectionManager.h"
#import "ISDeviceSelectionViewControllerProtocol.h"
#import "ISDeviceSelectionViewController.h"
#import "ISBluetoothBuffer.h"
#import "TxPacket.h"
#import "ISConnectionPacketFactory.h"


@implementation ISManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _blueToothBuffer = [[ISBlueToothBuffer alloc] initWithManager:self];
        _deviceStatusProvider = [[ISDeviceStatusProvider alloc] initWithManager:self];
        _connectionManager = [[ISConnectionManager alloc] initWithManager:self
                                                     deviceStatusProvider:self.deviceStatusProvider];
        self.connectionPacketFactory = [[ISConnectionPacketFactory alloc] initWithManager:self];
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

- (void)sendRunFirmwarePacket {
    self.deviceStatusProvider.inputStickState = InputStickStateInit;
    [self sendData:[self.connectionPacketFactory prepareRunFirmwarePacket].dataBytes];
}

#pragma mark - Getters

- (InputStickState)inputStickState {
    return self.deviceStatusProvider.inputStickState;
}

- (CBPeripheral *)connectedPeripheral {
    return self.connectionManager.connectedPeripheral;
}

- (CBCharacteristic *)discoveredCharacteristic {
    return self.connectionManager.discoveredCharacteristic;
}

@end
