/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "CustomPacketTableViewController.h"

#import "InputStickManager.h"
#import "InputStickPacket.h"
#import "InputStickRxPacket.h"
#import "InputStickTxPacket.h"

#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"

static NSString *const CellReuseIdentifier = @"DemoCustomPacketCellIdentifier";


@implementation CustomPacketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Custom packet";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] registerForInputStickPacketNotificationsWithObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickPacketNotificationsWithObserver:self];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - InputStickPacketNotificationObserver

-(void)didReceiveInputStickPacket:(NSNotification *)notification {
    InputStickRxPacket *packet = notification.userInfo[InputStickNotificationPacketKey];
    //check if received packet is a response to previously sent packet (will have the same command byte)
    if (packet.command == CmdUSBPower) {
        Byte *packetBytes = packet.bytes;  //response payload bytes: command, param, payload0,...
        if (packetBytes[1] == 0x01) { //0x01 = success
            [InputStickUI showAlertWithTitle:@"Custom packet" withMessage:@"Action completed" viewController:self];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Commands";
    } else {
        return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Disable USB interface";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Enable USB interface";
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //if USB is disabled, connection state is always == InputStickWaitingForUSB
    //if USB is enabled, connection state can be either InputStickReady or InputStickWaitingForUSB (depends on USB host)
    InputStickConnectionState state = self.inputStickManager.connectionState;
    if (state == InputStickReady || state == InputStickWaitingForUSB) {
        InputStickTxPacket *packet = nil;
        if (indexPath.row == 0) {
            //disable USB
            packet = [[InputStickTxPacket alloc] initWithCmd:CmdUSBPower withParam:0x00];
            packet.requiresResponse = YES; //request response (confirmation), see didReceiveInputStickPacket
        } else if (indexPath.row == 1) {
            //enable USB
            packet = [[InputStickTxPacket alloc] initWithCmd:CmdUSBPower withParam:0x01];
            [packet addByte:0x03]; //adding payload byte, in case of CmdUSBPower command it will be ignored
            packet.requiresResponse = NO; //send and forget, there will be no response packet
        }
        if (packet != nil) {
            NSLog(@"sending custom packet");
            [self.inputStickManager sendPacket:packet];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
