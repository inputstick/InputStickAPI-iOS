/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header MousepadViewController.h
 @brief shows how to use Mousepad area to control mouse or touch-screen interface
 */

#import <UIKit/UIKit.h>
#import "InputStickMouseInputView.h"

@class InputStickManager;

@interface MousepadViewController : UIViewController <InputStickMouseInputViewDelegate>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
