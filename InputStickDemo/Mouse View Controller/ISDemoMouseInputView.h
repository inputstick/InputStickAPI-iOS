//
// Created by Marcin Wieclawski on 03/11/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class ISDemoMouseInputView;

@protocol ISDemoMouseInputViewDelegate <NSObject>
- (void)mouseInputView:(ISDemoMouseInputView *)inputView didReceiveMoveAtPoint:(CGPoint)movePoint;

- (void)mouseInputView:(ISDemoMouseInputView *)view didReceiveScrollValue:(CGFloat)scrollValue;

@end

@interface ISDemoMouseInputView : UIView
@property(nonatomic, strong) id <ISDemoMouseInputViewDelegate> delegate;
@property(nonatomic, strong) UILabel *touchLabel;

@end
