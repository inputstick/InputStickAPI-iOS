/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISDeviceSelectionViewController.h"
#import "ISConnectionManager.h"
#import "ISDeviceSelectionTableViewCell.h"
#import "MBProgressHUD.h"


@implementation ISDeviceSelectionViewController
@synthesize connectionManager = _connectionManager;
@synthesize selectedPeripheral = _selectedPeripheral;

#pragma mark - Object lifecycle

- (instancetype)initWithConnectionManager:(ISConnectionManager *)connectionManager {
    self = [super init];
    if (self) {
        self.connectionManager = connectionManager;
        [[NSNotificationCenter defaultCenter] registerForConnectionNotificationsWithObserver:self];
        self.title = @"Available bluetooth devices";
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromConnectionNotificationsWithObserver:self];
}

#pragma mark - ViewController specific

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ISDeviceSelectionTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    return tableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.connectionManager.foundPeripherals.count;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = self.connectionManager.foundPeripherals[(NSUInteger) indexPath.item];
    [(ISDeviceSelectionTableViewCell *) cell configureWithPeripheral:peripheral];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedPeripheral) {
        return;
    }
    self.selectedPeripheral = self.connectionManager.foundPeripherals[(NSUInteger) indexPath.item];
    [self.connectionManager connectToPeripheral:self.selectedPeripheral];
}

#pragma mark - Connection Notification Observer protocol

- (void)didUpdatePeripheralsList:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)willStartConnectingPeripheral:(NSNotification *)notification {
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.progressHUD.labelText = @"Bluetooth";
    self.progressHUD.detailsLabelText = @"Connecting";

    __weak typeof(self) weakSelf = self;
    NSString *selectedPeripheralIdentifier = [self.selectedPeripheral.identifier UUIDString];
    [self.progressHUD setCompletionBlock:^{
        [ISConnectionManager setInputStickDeviceIdentifier:selectedPeripheralIdentifier];

        if (weakSelf.navigationController) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)didFinishConnectingPeripheral:(NSNotification *)notification {
    NSError *connectionError = notification.userInfo[@"error"];
    if (connectionError) {
        [self connectionFailed];
    } else {
        self.progressHUD.labelText = @"Input Stick";
        self.progressHUD.detailsLabelText = @"Connecting";
    }
}

- (void)didFinishConnectingInputStick:(NSNotification *)notification {
    NSError *connectionError = notification.userInfo[@"error"];
    if (connectionError) {
        [self connectionFailed];
    } else {
        self.progressHUD.detailsLabelText = @"Connected";
        [self.progressHUD hide:YES afterDelay:0.25];
    }
}

- (void)didDisconnectInputStickNotification:(NSNotification *)notification {
    [self connectionFailed];
}

#pragma mark - Connection Error helpers

- (void)connectionFailed {
    self.progressHUD.detailsLabelText = @"Connection failed";
    [self.progressHUD setCompletionBlock:nil];
    [self.progressHUD hide:YES afterDelay:1];
    self.selectedPeripheral = nil;
}

@end
