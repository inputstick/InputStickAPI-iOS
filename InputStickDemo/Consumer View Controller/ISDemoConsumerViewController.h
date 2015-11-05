//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class ISConsumerHandler;

@interface ISDemoConsumerViewController : UITableViewController
@property(nonatomic, readonly) ISConsumerHandler *consumerHandler;

- (instancetype)initWithConsumerHandler:(ISConsumerHandler *)consumerHandler;

@end
