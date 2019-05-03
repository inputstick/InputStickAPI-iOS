/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDBuffersState.h"
#import "InputStickHIDTransaction.h"
#import "InputStickHIDReport.h"
#import "InputStickManager.h"
#import "InputStickTxPacket.h"
#import "NSNotificationCenter+InputStickStatusUpdate.h"

static const NSInteger DefaultBufferCapacity = 32;
static const NSInteger DefaultMaxReportsPerPacket = 32;


@interface InputStickHIDTransactionBuffer () {
    InputStickHIDInterface _interface;
    NSUInteger _emptyCnt;
    NSUInteger _reportsSentSinceLastNotification;
}

@end


@implementation InputStickHIDTransactionBuffer

- (instancetype)initWithInputStickManager:(InputStickManager *)manager withHIDInterface:(InputStickHIDInterface)interface {
    self = [super init];
    if (self) {
        _manager = manager;
        _interface = interface;
        _queue = [NSMutableArray array];
        _freeSpace = DefaultBufferCapacity;
        _capacity = DefaultBufferCapacity;
        _maxReportsPerPacket = DefaultMaxReportsPerPacket;
    }
    return self;
}

- (BOOL)bufferEmpty {
    @synchronized(self.queue) {
        return (([_queue count] == 0) && (_freeSpace == _capacity));
    }
}

- (BOOL)localBufferEmpty {
    @synchronized(self.queue) {
        return ([_queue count] == 0);
    }
}


#pragma mark - Setup & State Update

- (void)setupWithCapacity:(NSUInteger)capacity maxReportsPerPacket:(NSUInteger)maxReports {
    @synchronized(self.queue) {
        [_queue removeAllObjects];
        _capacity = capacity;
        _maxReportsPerPacket = maxReports;
        _freeSpace = _capacity;
    }
}

- (void)updateWithNumberOfReportsSentToHost:(NSUInteger)reportsCount isEmpty:(BOOL)isEmpty {
    @synchronized(self.queue) {
        _freeSpace += reportsCount;
        //failsafe:
        if (_freeSpace > _capacity) {
            _freeSpace = _capacity;
        }
        if ((isEmpty) && (reportsCount == 0)) {
            if (_freeSpace != _capacity) {
                _emptyCnt++;
                if (_emptyCnt == 5) {
                    _freeSpace = _capacity;
                    _emptyCnt = 0;
                    [self postEmptyBufferNotification];
                }
            }

        } else {
            _emptyCnt = 0;
        }
        

        if ([_queue count] == 0) {
            if ((_freeSpace == _capacity) && (_reportsSentSinceLastNotification != 0)) {
                _reportsSentSinceLastNotification = 0;
                [self postEmptyBufferNotification];
            }
        } else {
            [self flush];
        }
    }
}

- (void)flush {
    @synchronized(self.queue) {
        BOOL didSend;
        do {
            didSend = FALSE;
            if (([_queue count] > 0) && (_freeSpace > 0)) {
                NSUInteger reportsToSendCount = 0;
                NSUInteger remainingReports = (_freeSpace > _maxReportsPerPacket) ? _maxReportsPerPacket : _freeSpace;
                InputStickTxPacket *packet = [[InputStickTxPacket alloc] initWithCmd:0]; //cmd will be set before packt is sent
                InputStickHIDTransaction *transaction = [_queue firstObject];
                InputStickCmd firstTransactionCmd = transaction.packetCmd;
                InputStickCmd transactionCmd;
                while(TRUE) {
                    if ([_queue count] == 0) {
                        break;
                    }
                    transaction = [_queue objectAtIndex:0];
                    transactionCmd = transaction.packetCmd;
                    if (transactionCmd != firstTransactionCmd) {
                        break;
                    }
                    if (transaction.reportsCount > remainingReports) {
                        break;
                    }
                    remainingReports -= transaction.reportsCount;
                    reportsToSendCount += transaction.reportsCount;
                    while (transaction.hasNext) {
                        InputStickHIDReport *report = [transaction pollReport];
                        [packet addBytes:report.bytes withLength:report.length];
                    }
                    [_queue removeObjectAtIndex:0];
                }
                
                if (reportsToSendCount > 0) {
                    packet.command = firstTransactionCmd;  
                    packet.param = reportsToSendCount;
                    [self.manager sendPacket:packet];
                    _freeSpace -= reportsToSendCount;
                    _reportsSentSinceLastNotification += reportsToSendCount;
                    didSend = TRUE;
                }
                
                if ([_queue count] == 0) {
                    [self postEmptyLocalBufferNotification];
                }
            }
        } while (didSend);
    }
}

- (void)addHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush {
    InputStickHIDTransaction *transaction = [[InputStickHIDTransaction alloc] initWithCmd:report.packetCmd];
    [transaction addHIDReport:report];
    [self addHIDTransaction:transaction flush:flush];
}

- (void)addHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush {
    if (self.manager.connectionState == InputStickReady) {
        @synchronized(_queue) {
            //split transactions that can't be sent in a single packet
            while (transaction.reportsCount > _maxReportsPerPacket) {
                InputStickHIDTransaction *tmp = [transaction splitBy:_maxReportsPerPacket];
                [_queue addObject:tmp];
            }
            [_queue addObject:transaction];
            if (flush) {
                [self flush];
            }
        }
    }
}

- (void)clear {
    @synchronized(self.queue) {
        NSUInteger cnt = [_queue count];
        [_queue removeAllObjects];
        if (cnt) {
            [self postEmptyLocalBufferNotification];
        }
    }
}


#pragma mark Helpers

- (void)postEmptyLocalBufferNotification {
    if (_interface == InputStickHIDInterfaceKeyboard) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickKeyboardLocalBuffer];
    } else if (_interface == InputStickHIDInterfaceMouse) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickMouseLocalBuffer];
    } else if (_interface == InputStickHIDInterfaceConsumer) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickConsumerLocalBuffer];
    }
}

- (void)postEmptyBufferNotification {
    if (_interface == InputStickHIDInterfaceKeyboard) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickKeyboardBuffer];
    } else if (_interface == InputStickHIDInterfaceMouse) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickMouseBuffer];
    } else if (_interface == InputStickHIDInterfaceConsumer) {
        [[NSNotificationCenter defaultCenter] postDidEmptyInputStickConsumerBuffer];
    }
}

@end
