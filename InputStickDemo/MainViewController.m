/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainViewController.h"
#import "ISManager.h"
#import "ISBluetoothBuffer.h"
#import "ISKeyboardHandler.h"


@interface MainViewController ()
@property(nonatomic, strong) UIButton *connectButton;
@property(nonatomic, strong) UIButton *reconnectButton;
@property(nonatomic, strong) UIButton *disconnectButton;
@property(nonatomic, strong) UIButton *sendDataButton;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inputStickManager = [[ISManager alloc] init];
        self.inputStickManager.delegate = self;

        self.keyboardHandler = [[ISKeyboardHandler alloc] initWithInputStickManager:self.inputStickManager];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];

    NSInteger horizontalMarginSize = 15;
    CGFloat buttonWidth = CGRectGetWidth(self.view.frame)  - 2 * horizontalMarginSize;
    self.connectButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, 15, buttonWidth, 44)];
    [self.connectButton setTitle:@"Connect with any device" forState:UIControlStateNormal];
    [self.connectButton setBackgroundColor:[UIColor grayColor]];
    [self.connectButton addTarget:self action:@selector(connectToAnyInputStickDevice:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.connectButton];

    self.reconnectButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, CGRectGetMaxY(self.connectButton.frame) + 15, buttonWidth, 44)];
    [self.reconnectButton setTitle:@"Reconnect with last device" forState:UIControlStateNormal];
    [self.reconnectButton setBackgroundColor:[UIColor grayColor]];
    [self.reconnectButton addTarget:self action:@selector(reconnectToPreviousInputStickDevice:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reconnectButton];

    self.disconnectButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, CGRectGetMaxY(self.reconnectButton.frame) + 15, buttonWidth, 44)];
    [self.disconnectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    [self.disconnectButton setBackgroundColor:[UIColor grayColor]];
    [self.disconnectButton addTarget:self action:@selector(disconnectInputStickDevice:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.disconnectButton];

    self.sendDataButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, CGRectGetMaxY(self.disconnectButton.frame) + 15, buttonWidth, 44)];
    [self.sendDataButton setTitle:@"Send text" forState:UIControlStateNormal];
    [self.sendDataButton setBackgroundColor:[UIColor grayColor]];
    [self.sendDataButton addTarget:self action:@selector(queueItemsToSend:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendDataButton];
}

- (void)connectToAnyInputStickDevice:(UIButton *)button {
    [self.inputStickManager connectToInputStickUsingStoredIdentifier:NO];
}

- (void)reconnectToPreviousInputStickDevice:(UIButton *)button {
    [self.inputStickManager connectToInputStickUsingStoredIdentifier:YES];
}

- (void)disconnectInputStickDevice:(UIButton *)button {
    [self.inputStickManager disconnectInputStickDevice];
}

#pragma mark - Bluetooth Manager Delegate

- (void)queueItemsToSend:(UIButton *)button {
    [self.keyboardHandler sendText:@"Short text message.\nWith two lines.\n"
                withKeyboardLayout:nil
                        multiplier:1];
}

#pragma mark - ISManager Delegate

- (void)inputStickManager:(ISManager *)inputStickManager presentViewController:(UIViewController *)deviceSelectionViewController {
    [self.navigationController pushViewController:deviceSelectionViewController animated:YES];
}

@end
