/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISBluetoothBuffer.h"
#import "TxPacket.h"
#import "ISDeviceBuffersState.h"
#import "TxPacket+KeyboardKeyModel.h"
#import "ISManager.h"
#import "ISKeyboardKeyModel.h"
#import "ISKeyboardReport.h"

const NSInteger BufferCapacity = 32;

@interface ISBlueToothBuffer ()
@property(nonatomic, strong) NSMutableArray *keyboardReportsQueue;
@property(nonatomic, strong) NSMutableArray *mouseReportQueue;

@property(nonatomic) NSInteger freeSpaceKeyboard;
@property(nonatomic) NSInteger freeSpaceMouse;
@end

@implementation ISBlueToothBuffer

- (instancetype)initWithManager:(ISManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;

        self.keyboardReportsQueue = [NSMutableArray array];
        self.mouseReportQueue = [NSMutableArray array];

        self.freeSpaceKeyboard = BufferCapacity;
        self.freeSpaceMouse = BufferCapacity;

        [[NSNotificationCenter defaultCenter] registerForDeviceStatusNotificationsWithObserver:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromDeviceStatusNotificationsWithObserver:self];
}

#pragma mark - Keyboard

- (void)addKeyboardReportToQueue:(ISKeyboardReport *)keyboardReport sendASAP:(BOOL)sendASAP {
    [self.keyboardReportsQueue addObject:keyboardReport];
    if (sendASAP) {
        [self sendKeyboard];
    }
}

- (void)addKeyboardKeyModelToQueue:(ISKeyboardKeyModel *)keyboardKeyModel sendASAP:(BOOL)sendASAP {
    NSArray *keyboardReports = [keyboardKeyModel keyboardReports];
    [self.keyboardReportsQueue addObjectsFromArray:keyboardReports];
    if (sendASAP) {
        [self sendKeyboard];
    }
}

- (void)sendKeyboard {
    NSUInteger numberOfKeyboardReportToSend = MIN(self.keyboardReportsQueue.count, self.freeSpaceKeyboard);

    if (numberOfKeyboardReportToSend > 0) {
        self.freeSpaceKeyboard -= numberOfKeyboardReportToSend;
        NSIndexSet *indexesOfKeyboardReports = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, numberOfKeyboardReportToSend)];
        NSArray *keyboardReportToSend = [self.keyboardReportsQueue objectsAtIndexes:indexesOfKeyboardReports];

        TxPacket *packet = [[TxPacket alloc] initWithPacketType:PacketTypeQueueSHORTKeyboardReports];
        for (NSUInteger i = 0; i < numberOfKeyboardReportToSend; ++i) {
            ISKeyboardReport *keyboardReport = keyboardReportToSend[i];
            [packet addBytesFromKeyboardReport:keyboardReport];
        }
        [self.keyboardReportsQueue removeObjectsAtIndexes:indexesOfKeyboardReports];

        [self.manager sendData:packet.dataBytes];
    }
}

#pragma mark - Mouse

- (void)sendMouse {
    //TODO: Implement mouse handling
}

#pragma mark - ResponseParsingNotificationObserver

- (void)didUpdateDeviceBuffersNotification:(NSNotification *)notification {
    ISDeviceBuffersState *responseUpdateModel = notification.userInfo[@"responseUpdateModel"];
    self.freeSpaceKeyboard += responseUpdateModel.sendKeyboardReports;
    self.freeSpaceMouse += responseUpdateModel.sendMouseReports;

    [self sendKeyboard];
    [self sendMouse];
}

- (void)clearQueues {
    [self.keyboardReportsQueue removeAllObjects];
    [self.mouseReportQueue removeAllObjects];

    self.freeSpaceKeyboard = BufferCapacity;
    self.freeSpaceMouse = BufferCapacity;
}

@end
