//
// Created by Marcin Wieclawski on 16/06/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "CoreBluetooth/CoreBluetooth.h"
#import "ISManagerDelegate.h"

@class ISManager;
@class ISBlueToothBuffer;
@class ISKeyboardHandler;
@class ISMouseHandler;

@interface MainViewController : UIViewController <ISManagerDelegate>
@property(nonatomic, strong) ISManager *inputStickManager;
@property(nonatomic, strong) ISKeyboardHandler *keyboardHandler;
@property(nonatomic, strong) ISMouseHandler *mouseHandler;

@end
