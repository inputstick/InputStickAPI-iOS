/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainViewController.h"
#import "ISManager.h"
#import "ISBluetoothBuffer.h"
#import "ISKeyboardHandler.h"
#import "ISMouseHandler.h"


@interface MainViewController ()
@property(nonatomic, strong) UIButton *connectButton;
@property(nonatomic, strong) UIButton *reconnectButton;
@property(nonatomic, strong) UIButton *disconnectButton;
@property(nonatomic, strong) UIButton *sendDataButton;
@property(nonatomic, strong) UIButton *mouseMoveRightButton;
@property(nonatomic, strong) UIButton *mouseMoveLeftButton;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inputStickManager = [[ISManager alloc] init];
        self.inputStickManager.delegate = self;

        self.keyboardHandler = [[ISKeyboardHandler alloc] initWithInputStickManager:self.inputStickManager];
        self.mouseHandler = [[ISMouseHandler alloc] initWithInputStickManager:self.inputStickManager];
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
    [self.sendDataButton addTarget:self action:@selector(sendSimpleText:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendDataButton];
    
    self.mouseMoveRightButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, CGRectGetMaxY(self.sendDataButton.frame) + 15, buttonWidth, 44)];
    [self.mouseMoveRightButton setTitle:@"Mouse move right" forState:UIControlStateNormal];
    [self.mouseMoveRightButton setBackgroundColor:[UIColor grayColor]];
    [self.mouseMoveRightButton addTarget:self action:@selector(moveMouseRight:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mouseMoveRightButton];
    
    self.mouseMoveLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(horizontalMarginSize, CGRectGetMaxY(self.mouseMoveRightButton.frame) + 15, buttonWidth, 44)];
    [self.mouseMoveLeftButton setTitle:@"Mouse move left" forState:UIControlStateNormal];
    [self.mouseMoveLeftButton setBackgroundColor:[UIColor grayColor]];
    [self.mouseMoveLeftButton addTarget:self action:@selector(moveMouseLeft:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mouseMoveLeftButton];
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

#pragma mark - Keyboard - demo usage

- (void)sendSimpleText:(UIButton *)button {
    [self.keyboardHandler sendText:@"Short text message.\nWith two lines.\n"
                withKeyboardLayout:nil
                        multiplier:1];
}

#pragma mark - Mouse - demo usage

- (void)moveMouseRight:(UIButton *)button {
    [self.mouseHandler sendMoveWithX:0x50 positionY:0x00];
}

- (void)moveMouseLeft:(UIButton *)moveMouseLeft {
    [self.mouseHandler sendMoveWithX:-0x50 positionY:0x00];
}

#pragma mark - ISManager Delegate

- (void)inputStickManager:(ISManager *)inputStickManager presentViewController:(UIViewController *)deviceSelectionViewController {
    [self.navigationController pushViewController:deviceSelectionViewController animated:YES];
}

@end
