/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "PeripheralSelectionTableViewController.h"

#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickPeripheralInfo.h"

#import "InputStickUI.h"

static NSString *const CellReuseIdentifier = @"DemoPeripheralSelectionCellIdentifier";


@interface PeripheralSelectionTableViewController () {
    BOOL _scanning;
}

@end

//for more detailed example see: iOS/ViewControllers/InputStickDeviceSelectionViewController

@implementation PeripheralSelectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select device";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    [self navigationItem].rightBarButtonItem = activityButton;
    [activityIndicator startAnimating];
    
    [self startScan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.inputStickManager stopBluetoothPeripheralScan];
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self]; //pre iOS9
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - InputStickConnectionNotification Observer

- (void)didUpdateInputStickPeripheralsList:(NSNotification *)notification {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:NO]; //update section containing list of discovered devices
}

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    InputStickConnectionState state = self.inputStickManager.connectionState;
    if (state == InputStickReady) {
        [self.navigationController popViewControllerAnimated:YES]; //connected, go back to previous view controller
    } else {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO]; //update connection status info
    }
    
    NSError *error = self.inputStickManager.lastError;
    if (error) {
        //BT peripheral scan is stopped once BT connection is established (InputStickInitializing state)
        //if it fails to complete initialization, connection error occurs and it is necessary to manually restart BT peripheral scan
        [self startScan];
    }
}

- (void)didStartInputStickPeripheralScan {
    _scanning = TRUE;    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO]; //update status cell:
}

- (void)didFinishInputStickPeripheralScan {
    _scanning = FALSE;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO]; //update status cell
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Status";
    } else if (section == 1) {
        return @"Found peripherals";
    } else {
        return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return [self.inputStickManager.connectionManager.foundPeripherals count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        //BT scan / connection state
        InputStickConnectionState state = self.inputStickManager.connectionState;
        if (indexPath.row == 0) {
            NSString *stateDescriptionString;
            if (state == InputStickDisconnected) {
                if (_scanning) {
                    stateDescriptionString = @"Scanning for peripherals...";
                } else {
                    //this should never happen; if state is connection error occurs, peripheral scan will be restarted
                    stateDescriptionString = @"Disconnected/Scan stopped";
                }
            } else {
                stateDescriptionString = [InputStickUI nameForInputStickConnectionState:state];
            }
            cell.textLabel.text = stateDescriptionString;
            cell.userInteractionEnabled = NO;
        }
    } else if (indexPath.section == 1) {
        //device info:
        InputStickPeripheralInfo *info = [self.inputStickManager.connectionManager.foundPeripherals objectAtIndex:indexPath.row];
        cell.textLabel.text = info.name;
        cell.userInteractionEnabled = YES; 
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        //connect to selected peripheral, scan will be automatically stopped once connected
        InputStickPeripheralInfo *info = [self.inputStickManager.connectionManager.foundPeripherals objectAtIndex:indexPath.row];
        [self.inputStickManager connectToInputStickWithIdentifier:info.identifier];
        NSLog(@"connecting to: %@", info.name);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - BT Scan

- (void)startScan {
    NSLog(@"starting peripheral scan...");
    [self.inputStickManager startBluetoothPeripheralScanWithTimeout:FALSE];
    _scanning = TRUE; //in case scan was already in progress (in that case there will be no notification)
}

@end
