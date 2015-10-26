/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISDeviceStatusProvider.h"
#import "TxPacket.h"
#import "NSNotificationCenter+DeviceStatus.h"
#import "ISDeviceBuffersState.h"
#import "ISConnectionPacketFactory.h"


const NSInteger startTag = 0x55;

@interface ISDeviceStatusProvider ()
@property(nonatomic) BOOL isPerformingDeviceInitialization;
@property(nonatomic, strong) NSString *encryptionKey;

@property(nonatomic) ResponseParsingState responseState;    //current parsing state
@property(nonatomic) NSUInteger responsePosition;           //current buffer position in the response
@property(nonatomic) NSUInteger responseLength;             //expect response size
@property(nonatomic, strong) NSMutableData *responseData;   //response data buffer

@end

@implementation ISDeviceStatusProvider

- (instancetype)initWithManager:(ISManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
        _inputStickState = InputStickStateDisconnected;
        self.responseState = ResponseStateTAG;
        self.connectionPacketFactory = [[ISConnectionPacketFactory alloc] initWithManager:manager];
        [[NSNotificationCenter defaultCenter] registerForConnectionNotificationsWithObserver:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromConnectionNotificationsWithObserver:self];
}

#pragma mark - Build packet with bytes

- (void)parseResponseBytes:(Byte *)responseBytes withLength:(NSUInteger)length {
    for (int i = 0; i < length; ++i) {
        [self parseSingleResponseByte:responseBytes[i]];
    }
}

- (void)parseSingleResponseByte:(Byte)responseByte {
    switch (self.responseState) {
        case ResponseStateTAG:
            if (responseByte == startTag) {
                self.responseState = ResponseStateLength;
                self.responseData = nil;
            }
            break;
        case ResponseStateLength:
            self.responseLength = (NSUInteger) (responseByte & 0x3F);
            self.responseLength *= 16;
            self.responsePosition = 0;

            self.responseData = [NSMutableData dataWithLength:self.responseLength];

            self.responseState = ResponseStateData;
            break;
        case ResponseStateData:
            if (self.responsePosition < self.responseLength) {
                ((Byte *) self.responseData.bytes)[self.responsePosition] = responseByte;
                self.responsePosition++;
                if (self.responsePosition == self.responseLength) {
                    [self interpretResponsePacketWithData:[self responsePacketWithReceivedBytes]];
                    self.responseState = ResponseStateTAG;
                }
            } else {
                self.responseState = ResponseStateTAG;
                [NSException raise:NSInvalidArgumentException format:@"Buffer overrun!"];
            }
            break;
    }
}

#pragma mark - Parse response packet

- (void)interpretResponsePacketWithData:(NSData *)data {
    Byte *packetBytes = data.bytes;
    int commandByte = packetBytes[0];
    switch (commandByte) {
        case PacketTypeRunFirmware: {
            self.isPerformingDeviceInitialization = YES;
            [self.manager sendData:[self.connectionPacketFactory prepareGetFirmwareInfoPacket].dataBytes];
        }
        case PacketTypeGetFirmwareInfo: {
            //TODO: Parse response for encryption info
            BOOL encrypted = NO;
            if (encrypted) {
                [self.manager sendData:[self.connectionPacketFactory prepareAuthenticatePacket].dataBytes];
            } else {
                self.inputStickState = InputStickStateWaitingForUSB;
            }
        }
            break;
        case PacketTypeAuthenticate: {
            BOOL cypherOk = YES;
            NSAssert(cypherOk, @"Invalid encryption key");
            self.inputStickState = InputStickStateWaitingForUSB;
        };
            break;
        case ResponsePacketTypeUSBHIDStatusUpdate: {
            if (self.inputStickState != InputStickStateReady) {
                if (packetBytes[1] == 0x05) {
                    self.inputStickState = InputStickStateReady;
                    if (self.isPerformingDeviceInitialization) {
                        [[NSNotificationCenter defaultCenter] postDidFinishConnectingInputStickNotificationWithConnectionManager:self.manager.connectionManager
                                                                                                                       withError:nil];
                        self.isPerformingDeviceInitialization = NO;
                    }
                } else {
                    self.inputStickState = InputStickStateWaitingForUSB;
                }
            }
            ISDeviceBuffersState *responseUpdateModel = [[ISDeviceBuffersState alloc] init];
            responseUpdateModel.sendKeyboardReports = packetBytes[8];
            responseUpdateModel.sendMouseReports = packetBytes[9];
            responseUpdateModel.sendConsumerReports = packetBytes[10];
            [[NSNotificationCenter defaultCenter] postDidUpdateDeviceBuffersStateWithModel:responseUpdateModel
                                                                            statusProvider:self];

            Byte ledValues = packetBytes[2];
            [[NSNotificationCenter defaultCenter] postDidUpdateKeyboardLedsWithValue:ledValues
                                                                      statusProvider:self];
        }
            break;
        default: {
            NSString *errorMessage = [NSString stringWithFormat:@"Invalid response byte received: [0]: %d [1]: %d",
                                                                packetBytes[0],
                                                                packetBytes[1]];
            NSLog(errorMessage);
        }
    }
}

#pragma mark - ConnectionNotificationObserver

- (void)willStartConnectingPeripheral:(NSNotification *)notification {
    self.inputStickState = InputStickStateConnecting;
}

- (void)didDisconnectInputStickNotification:(NSNotification *)notification {
    self.inputStickState = InputStickStateDisconnected;
}

#pragma mark - Helpers

- (NSData *)responsePacketWithReceivedBytes {
    //Dismisses first four bites containing CRC
    NSUInteger payloadSize = self.responseLength - 4;
    NSMutableData *payloadData = [NSMutableData dataWithLength:payloadSize];
    Byte *payload = payloadData.bytes;
    Byte *responseBytes = self.responseData.bytes;
    for (int i = 0; i < payloadSize; ++i) {
        payload[i] = responseBytes[i + 4];
    }
    NSData *data = [NSData dataWithBytes:payload length:payloadSize];
    return data;
}

@end
