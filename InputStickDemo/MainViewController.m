/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainViewController.h"
#import "ISManager.h"
#import "ISKeyboardHandler.h"
#import "ISMouseHandler.h"
#import "ISDemoKeyboardViewController.h"
#import "ISDemoMouseViewController.h"
#import "ISDemoConsumerViewController.h"
#import "ISConsumerHandler.h"


@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inputStickManager = [[ISManager alloc] init];
        self.inputStickManager.delegate = self;

        self.keyboardHandler = [[ISKeyboardHandler alloc] initWithInputStickManager:self.inputStickManager];
        self.mouseHandler = [[ISMouseHandler alloc] initWithInputStickManager:self.inputStickManager];
        self.consumerHandler = [[ISConsumerHandler alloc] initWithManager:self.inputStickManager];

        [[NSNotificationCenter defaultCenter] registerForConnectionNotificationsWithObserver:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromConnectionNotificationsWithObserver:self];
}

- (void)loadView {
    [super loadView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"Input Stick";
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Status";
        case 1:
            return @"Connection";
        case 2:
            return @"HID Devices";
        default:
            return @"";
    }
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"CellIdentifier"];
    }
    return tableViewCell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.inputStickManager isReady] ? @"Connected" : @"Not connected";
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Connect with any device";
                break;
            case 1:
                cell.textLabel.text = @"Connect with last device";
                break;
            case 2:
                cell.textLabel.text = @"Disconnect";
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Keyboard";
                break;
            case 1:
                cell.textLabel.text = @"Mouse";
                break;
            case 2:
                cell.textLabel.text = @"Consumer";
                break;
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.inputStickManager connectToInputStickUsingStoredIdentifier:NO];
                break;
            case 1:
                [self.inputStickManager connectToInputStickUsingStoredIdentifier:YES];
                break;
            case 2:
                [self.inputStickManager disconnectInputStickDevice];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        UIViewController *viewControllerToPresent;
        switch (indexPath.row) {
            case 0:
                viewControllerToPresent = [[ISDemoKeyboardViewController alloc] initWithKeyboardHandler:self.keyboardHandler];
                break;
            case 1:
                viewControllerToPresent = [[ISDemoMouseViewController alloc] initWithMouseHandler:self.mouseHandler];
                break;
            case 2:
                viewControllerToPresent = [[ISDemoConsumerViewController alloc] initWithConsumerHandler:self.consumerHandler];
                break;
            default:
                break;
        }
        [self.navigationController pushViewController:viewControllerToPresent
                                             animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Keyboard - demo usage

- (void)sendSimpleText:(UIButton *)button {
    [self.keyboardHandler sendText:@"Short text message.\nWith two lines.\n"
                withKeyboardLayout:nil
                        multiplier:1];
}

#pragma mark - ISManager Delegate

- (void)inputStickManager:(ISManager *)inputStickManager presentViewController:(UIViewController *)deviceSelectionViewController {
    [self.navigationController pushViewController:deviceSelectionViewController animated:YES];
}

#pragma mark - ConnectionNotificationObserver

- (void)willStartConnectingPeripheral:(NSNotification *)notification {
    [self didUpdateDeviceConnectionStatus];
}

- (void)didDisconnectInputStickNotification:(NSNotification *)notification {
    [self didUpdateDeviceConnectionStatus];
}

- (void)didFinishConnectingInputStick:(NSNotification *)notification {
    [self didUpdateDeviceConnectionStatus];
}

- (void)didUpdateDeviceConnectionStatus {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationNone];
}

@end
