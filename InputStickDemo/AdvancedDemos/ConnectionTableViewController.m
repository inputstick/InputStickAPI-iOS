/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "ConnectionTableViewController.h"
#import "PeripheralSelectionTableViewController.h"

#import "InputStickManager.h"

#import "InputStickUI.h"

static NSString *const CellReuseIdentifier = @"DemoConnectionCellIdentifier";


@implementation ConnectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"InputStick Connection";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //remove empty cells
    
    //custom back navigation button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self]; 
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - InputStickConnectionNotification Observer

-(void) didUpdateInputStickConnectionState:(NSNotification *)notification {
    [self.tableView reloadData]; //will update connection status table cell
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Connection status";
    } else if (section == 1) {
        return @"Connection actions";
    } else {
        return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1; //status
    } else if (section == 1) {
        return 3; //actions (connect / connect (discover) / disconnect
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    InputStickConnectionState state = self.inputStickManager.connectionState;
    
    NSString *stateDescriptionString = [InputStickUI nameForInputStickConnectionState:state];
    BOOL isDisconnected = (state == InputStickDisconnected);
    BOOL hasStoredDevice = [self.inputStickManager hasStoredDeviceIdentifier];
    
    if (indexPath.section == 0) {
        //connection status:
        cell.textLabel.text = stateDescriptionString;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //connect to the most recently used InputStick device:
            cell.textLabel.text = @"Connect (last device)";
            cell.textLabel.enabled = (isDisconnected && hasStoredDevice);
            cell.userInteractionEnabled = (isDisconnected && hasStoredDevice);
        } else if (indexPath.row == 1) {
            //connect to manually selected device:
            cell.textLabel.text = @"Connect (discover devices)";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.enabled = isDisconnected;
            cell.userInteractionEnabled = isDisconnected;
        } else if (indexPath.row == 2) {
            //disconnect (enabled only if connected):
            cell.textLabel.text = @"Disconnect";
            cell.textLabel.enabled = !isDisconnected;
            cell.userInteractionEnabled = !isDisconnected;
        }
    }
    
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //connect to the most recently used InputStick device:
            if ([InputStickUI checkIfBluetoothIsOn:self.inputStickManager viewController:self]) {
                [self.inputStickManager connectToLastInputStick];
            }
        } else if (indexPath.row == 1) {
            //connect to manually selected device:
            if ([InputStickUI checkIfBluetoothIsOn:self.inputStickManager viewController:self]) {
                PeripheralSelectionTableViewController *vc = [[PeripheralSelectionTableViewController alloc] init];
                vc.inputStickManager = self.inputStickManager;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } else if (indexPath.row == 2) {
            //disconnect (enabled only if connected):
            [self.inputStickManager disconnectFromInputStick];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
