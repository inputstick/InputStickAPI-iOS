//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ISDemoMouseInputView.h"

@class ISMouseHandler;
@class ISDemoMouseInputView;

@interface ISDemoMouseViewController : UIViewController <ISDemoMouseInputViewDelegate>
@property(nonatomic, strong) ISMouseHandler *mouseHandler;

@property(nonatomic, strong) ISDemoMouseInputView *mouseInputView;

@property(nonatomic, strong) UIButton *leftMouseButton;
@property(nonatomic, strong) UIButton *centerMouseButton;
@property(nonatomic, strong) UIButton *rightMouseButton;

-(instancetype)initWithMouseHandler:(ISMouseHandler *)mouseHandler;

@end
