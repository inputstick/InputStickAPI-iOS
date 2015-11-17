//
// Created by Marcin Wieclawski on 05/11/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ISGamepadHandler;

@interface ISDemoGamepadViewController : UIViewController
@property(nonatomic, strong) ISGamepadHandler *gamepadHandler;
@property(nonatomic, strong) UIButton *xButton;
@property(nonatomic, strong) UIButton *yButton;
@property(nonatomic, strong) UIButton *aButton;
@property(nonatomic, strong) UIButton *bButton;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *topButton;
@property(nonatomic, strong) UIButton *downButton;
@property(nonatomic, strong) UIButton *rightButton;

- (instancetype)initWithGamepadHandler:(ISGamepadHandler *)gamepadHandler;

@end
