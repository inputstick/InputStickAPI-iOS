//
// Created by Marcin Wieclawski on 16/06/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "CoreBluetooth/CoreBluetooth.h"

@interface MainViewController : UITableViewController <CBCentralManagerDelegate, CBPeripheralDelegate>
@property(nonatomic, strong) CBCentralManager *centralManager;
@property(nonatomic, strong) NSMutableArray *foundPeripherals;
@property(nonatomic, strong) CBPeripheral *connectedPeripheral;
@property(nonatomic, strong) CBCharacteristic *discoveredCharacteristic;;
@end
