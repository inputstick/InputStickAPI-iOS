/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "HIDGamepadViewController.h"

#import <CoreMotion/CoreMotion.h>

#import "MainTableViewController.h"
#import "InputStickDemoUtils.h"
#import "InputStickHIDBuffersManager.h"

#import "InputStickGamepadHandler.h"

#import "InputStickUI.h"
#import "InputStickBarButtonItem.h"


@interface HIDGamepadViewController () {
    UILabel *_labelInfo;
    UIButton *_buttonGamepadA;
    UIButton *_buttonGamepadB;
    UIButton *_buttonGamepadC;
    UIButton *_buttonGamepadD;
    
    int _buttons;
    SignedByte _x;
    SignedByte _y;
    
    CMMotionManager *_motionManager;
    BOOL _landscape;  //not used, orientation change is locked by MainTableViewController
    
    NSTimer *_gamepadTimer;
}

@end


@implementation HIDGamepadViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Gamepad";
    
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = 0.05; 
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                         withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                             [self outputAccelertionData:accelerometerData.acceleration];
                                         }];
    
    _gamepadTimer = [NSTimer scheduledTimerWithTimeInterval:0.025f target:self selector:@selector(sendUpdate) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_gamepadTimer invalidate];
    //special case: queue this report (resets gamepad state) to make 100% sure that it is received by USB host
    InputStickHIDReport *report = [self.inputStickManager.gamepadHandler customReportWithButtons:0 axisX:0 axisY:0 axisZ:0 axisRX:0];
    [self.inputStickManager.buffersManager addConsumerHIDReport:report flush:TRUE];
    
    
    [_motionManager stopAccelerometerUpdates];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Gamepad timer

- (void)sendUpdate {
    //important! gamepad reports are not queued! they go directly into USB endpoint. if host is not ready, packet will be lost
    //this should not happen if updates are sent at >20ms intervals
    [self.inputStickManager.gamepadHandler sendCustomReportWithButtons:_buttons axisX:_x axisY:_y axisZ:0 axisRX:0];
}


#pragma mark - UIView

- (void)loadView {
    self.view = [[UIView alloc] init];
    
    _labelInfo = [[UILabel alloc] init];
    _labelInfo.numberOfLines = 2;
    self.view.backgroundColor = [InputStickUI backgroundColor];
    _labelInfo.textColor = [InputStickUI labelColor];
    
    _buttonGamepadA = [InputStickDemoUtils buttonWithTitle:@"A" tag:GamepadButton1];
    [_buttonGamepadA addTarget:self action:@selector(buttonGamepadPress:)
              forControlEvents:UIControlEventTouchDown];
    [_buttonGamepadA addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpInside];
    [_buttonGamepadA addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpOutside];
    [_buttonGamepadA addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchCancel];
    [_buttonGamepadA addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchDragExit];
    
    _buttonGamepadB = [InputStickDemoUtils buttonWithTitle:@"B" tag:GamepadButton2];
    [_buttonGamepadB addTarget:self action:@selector(buttonGamepadPress:)
              forControlEvents:UIControlEventTouchDown];
    [_buttonGamepadB addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpInside];
    [_buttonGamepadB addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpOutside];
    [_buttonGamepadB addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchCancel];
    [_buttonGamepadB addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchDragExit];
    
    _buttonGamepadC = [InputStickDemoUtils buttonWithTitle:@"C" tag:GamepadButton3];
    [_buttonGamepadC addTarget:self action:@selector(buttonGamepadPress:)
              forControlEvents:UIControlEventTouchDown];
    [_buttonGamepadC addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpInside];
    [_buttonGamepadC addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpOutside];
    [_buttonGamepadC addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchCancel];
    [_buttonGamepadC addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchDragExit];
    
    _buttonGamepadD = [InputStickDemoUtils buttonWithTitle:@"D" tag:GamepadButton4];
    [_buttonGamepadD addTarget:self action:@selector(buttonGamepadPress:)
              forControlEvents:UIControlEventTouchDown];
    [_buttonGamepadD addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpInside];
    [_buttonGamepadD addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchUpOutside];
    [_buttonGamepadD addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchCancel];
    [_buttonGamepadD addTarget:self action:@selector(buttonGamepadRelease:)
              forControlEvents:UIControlEventTouchDragExit];
    
    
    [self.view addSubview:_labelInfo];
    [self.view addSubview:_buttonGamepadA];
    [self.view addSubview:_buttonGamepadB];
    [self.view addSubview:_buttonGamepadC];
    [self.view addSubview:_buttonGamepadD];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _landscape = (self.view.frame.size.width > self.view.frame.size.height);
    
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat buttonSideLength = MIN(viewWidth, viewHeight) / 4;
    CGFloat centerX = viewWidth / 2;
    CGFloat centerY = viewHeight / 2;
    
    CGRect buttonFrame;
    
    buttonFrame = CGRectMake(0, 64, viewWidth, 50);
    [_labelInfo setFrame:buttonFrame];
    
    buttonFrame = CGRectMake(centerX - (buttonSideLength / 2), centerY - (1.5 * buttonSideLength), buttonSideLength, buttonSideLength);
    [_buttonGamepadA setFrame:buttonFrame];
    
    buttonFrame = CGRectMake(centerX - (1.5 * buttonSideLength), centerY - (buttonSideLength / 2), buttonSideLength, buttonSideLength);
    [_buttonGamepadB setFrame:buttonFrame];
    
    buttonFrame = CGRectMake(centerX + (0.5 * buttonSideLength), centerY - (buttonSideLength / 2), buttonSideLength, buttonSideLength);
    [_buttonGamepadC setFrame:buttonFrame];
    
    buttonFrame = CGRectMake(centerX - (buttonSideLength / 2), centerY + (0.5 * buttonSideLength), buttonSideLength, buttonSideLength);
    [_buttonGamepadD setFrame:buttonFrame];
}


#pragma mark - Gamepad Buttons Action

- (IBAction) buttonGamepadRelease:(id)sender {
    UIButton *clicked = (UIButton *)sender;
    _buttons &= ~clicked.tag;
}

- (IBAction) buttonGamepadPress:(id)sender {
    UIButton *clicked = (UIButton *)sender;
    _buttons |= clicked.tag;
}


#pragma mark - CMMotionManager

- (void)outputAccelertionData:(CMAcceleration)acceleration {
    if (_landscape) {
        _x = acceleration.y * 127;
    } else {
        _x = acceleration.x * 127;
    }
    _y = acceleration.z * 127;
    
    if (_x > 127) {
        _x = 127;
    }
    if (_y > 127) {
        _y = 127;
    }
    if (_x < -127) {
        _x = -127;
    }
    if (_y < -127) {
        _y = -127;
    }
    
    NSString *info;
    if (_landscape) {
        info = @"Landscape (locked)\n";
    } else {
        info = @"Portrait (locked)\n";
    }
    info = [info stringByAppendingFormat:@"x: %d, y: %d", _x, _y];
    _labelInfo.text = info;
}

@end
