/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISBluetoothBuffer.h"
#import "TxPacket.h"
#import "ISDeviceBuffersState.h"
#import "ISManager.h"
#import "ISKeyboardKeyModel.h"
#import "ISReport.h"
#import "TxPacket+Report.h"

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

- (void)addKeyboardReportToQueue:(ISReport *)keyboardReport sendASAP:(BOOL)sendASAP {
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
        [self sendPacketWithType:PacketTypeQueueSHORTKeyboardReports
                     withReports:[self takeFirst:numberOfKeyboardReportToSend
                                reportsFromQueue:self.keyboardReportsQueue]];
    }
}

#pragma mark - Mouse

- (void)addMouseReportToQueue:(ISReport *)mouseReport sendASAP:(BOOL)sendASAP {
    [self.mouseReportQueue addObject:mouseReport];
    if (sendASAP) {
        [self sendMouse];
    }
}

- (void)sendMouse {
    NSUInteger numberOfMouseReportsToSend = MIN(self.mouseReportQueue.count, self.freeSpaceMouse);
    if (numberOfMouseReportsToSend > 0) {
        self.freeSpaceMouse -= numberOfMouseReportsToSend;
        [self sendPacketWithType:PacketTypeQueueMouseReports
                     withReports:[self takeFirst:numberOfMouseReportsToSend reportsFromQueue:self.mouseReportQueue]];
    }
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

#pragma mark - Helpers

- (NSArray *)takeFirst:(NSUInteger)numberOfItems reportsFromQueue:(NSMutableArray *)targetArray {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, numberOfItems)];
    NSArray *fetchedItems = [targetArray objectsAtIndexes:indexes];
    [targetArray removeObjectsAtIndexes:indexes];
    return fetchedItems;
}

- (void)sendPacketWithType:(PacketTypes)type withReports:(NSArray *)reportsToSend {
    TxPacket *packet = [[TxPacket alloc] initWithPacketType:type];
    for (NSUInteger i = 0; i < reportsToSend.count; ++i) {
        ISReport *mouseReport = reportsToSend[i];
        [packet addBytesFromReport:mouseReport];
    }
    [self.manager sendData:packet.dataBytes];
}

@end
