/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickDeviceSelectionViewController.h"
#import "InputStickDeviceTableViewCell.h"
#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickConnectionManager.h"
#import "InputStickPeripheralInfo.h"
#import "InputStickDeviceDB.h"
#import "InputStickDeviceData.h"
#import "InputStickConst.h"

static float const RestartDelay = 1.00f;
static float const CloseDelay = 0.25f;
static NSString *const CellDeviceReuseIdentifier = @"InputStickDeviceSelectionDeviceCellIdentifier";
static NSString *const CellStatusReuseIdentifier = @"InputStickDeviceSelectionStatusCellIdentifier";


@interface InputStickDeviceSelectionViewController () {
    InputStickPeripheralInfo *_selectedPeripheralInfo;
    UITableViewCell *_statusTableViewCell;
    UIActivityIndicatorView *_cellActivityIndicatorView;
    UIBarButtonItem *_restartButton;
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_disconnectButton;
    
    NSMutableArray<InputStickPeripheralInfo *> *_knownDevices; //discovered peripherals that were previously connected to (stored in DB)
    NSMutableArray<InputStickPeripheralInfo *> *_unknownDevices; //discovered peripherals thet were never connected to

    BOOL _scanning;
    BOOL _done;
}

@end


@implementation InputStickDeviceSelectionViewController

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super init];
    if (self) {
        _inputStickManager = manager;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self]; //pre iOS9
}


#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TITLE", InputStickStringTable, nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellStatusReuseIdentifier];
    [self.tableView registerClass:[InputStickDeviceTableViewCell class] forCellReuseIdentifier:CellDeviceReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    _knownDevices = [[NSMutableArray alloc] init];
    _unknownDevices = [[NSMutableArray alloc] init];
    [self prepareData];
    
    _restartButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_BUTTON_RESTART_SCAN", InputStickStringTable, nil)
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(restartScan)];
    
    _cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_CANCEL", InputStickStringTable, nil)
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(disconnect)];
    
    _disconnectButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_DISCONNECT", InputStickStringTable, nil)
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(disconnect)];
    
    _cellActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [InputStickTheme themeActivityIndicatorView:_cellActivityIndicatorView];
    [InputStickTheme themeViewController:self];
    
    //pull down to force-restart BT scan
    if (@available(iOS 10, *)) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor whiteColor];
        self.refreshControl.tintColor = [UIColor blackColor];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_PULL_DOWN_TO_RESTART", InputStickStringTable, nil)];
        [self.refreshControl addTarget:self action:@selector(restartScan) forControlEvents:UIControlEventValueChanged];
        [InputStickTheme themeRefreshControl:self.refreshControl];
    }
    
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self]; 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputStickManager.inputStickMenuDelegate = self;
    [self restartScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.inputStickManager.inputStickMenuDelegate = nil;
    [self.inputStickManager stopBluetoothPeripheralScan];    
    [super viewWillDisappear:animated];
}


#pragma mark - InputStickManager Delegate

- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error {
    UIAlertController *alertController = [InputStickUI errorAlertDialog:error];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentKeyRemovedDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI keyRemovedAlertDialog:inputStickManager deviceData:deviceData];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    UIAlertController *alertController = [InputStickUI provideKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData];
    [self presentViewController:alertController animated:YES completion:nil];
    _done = FALSE; //do not pop view controller
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_STATUS", InputStickStringTable, nil);
    } else if (section == 1) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_SAVED_DEVICES", InputStickStringTable, nil);
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_NEARBY_DEVICES", InputStickStringTable, nil);
    } else {
        return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return [_knownDevices count];
    } else if (section == 2) {
        return [_unknownDevices count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell =  [self.tableView dequeueReusableCellWithIdentifier:CellStatusReuseIdentifier forIndexPath:indexPath];
        _statusTableViewCell = cell;
        [self updateUI];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellDeviceReuseIdentifier forIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        [InputStickTheme themeTableViewHeaderView:(UITableViewHeaderFooterView *)view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    InputStickPeripheralInfo *peripheralInfo = nil;
    if (indexPath.section == 1) {
        peripheralInfo = _knownDevices[(NSUInteger)indexPath.item];
    }
    if (indexPath.section == 2) {
        peripheralInfo = _unknownDevices[(NSUInteger)indexPath.item];
    }
    
    if (peripheralInfo != nil) {
        NSString *dbName;
        InputStickDeviceData *deviceData = [_inputStickManager.deviceDB getDataForDeviceWithIdentifier:peripheralInfo.identifier];
        if (deviceData != nil) {
            dbName = deviceData.name;
        }
        [(InputStickDeviceTableViewCell *)cell configureWithInputStickPeripheralInfo:peripheralInfo withDatabaseName:dbName];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedPeripheralInfo == nil) {
        if (indexPath.section == 1) {
            _selectedPeripheralInfo = _knownDevices[(NSUInteger) indexPath.item];
            [self.inputStickManager connectToInputStickWithIdentifier:_selectedPeripheralInfo.identifier];
        }
        if (indexPath.section == 2) {
            _selectedPeripheralInfo = _unknownDevices[(NSUInteger) indexPath.item];
            [self.inputStickManager connectToInputStickWithIdentifier:_selectedPeripheralInfo.identifier];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (([_knownDevices count] == 0) && ([_unknownDevices count] == 0)) {
            [InputStickUI showAlertWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_HELP", InputStickStringTable, nil)
                                 withMessage:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_HELP", InputStickStringTable, nil)
                              viewController:self];
        }
    }
}


#pragma mark - InputStickConnectionNotification Observer

- (void)didStartInputStickPeripheralScan {
    _scanning = TRUE;
    [self updateUI];
}

- (void)didFinishInputStickPeripheralScan {
    _scanning = FALSE;
    [self updateUI];
}

- (void)didTimeoutInputStickPeripheralScan {
}

- (void)didUpdateInputStickPeripheralsList:(NSNotification *)notification {
    [self prepareData];
    [self.tableView reloadData];
}

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    //InputStickConnectionState state = _inputStickManager.connectionState;
    if (self.inputStickManager.lastError != nil) {
        _done = FALSE; //lost connection before view controller got popped
    }
    [self updateUI];
}


#pragma mark - UI

- (void)disconnect {
    [_inputStickManager disconnectFromInputStick];
}


- (void)restartScan {
    _scanning = TRUE;
    [self updateUI]; //force UI update before scan is started (after RestartDelay)
    
    //stop scan & manually clean list
    [_inputStickManager stopBluetoothPeripheralScan];
    [_knownDevices removeAllObjects];
    [_unknownDevices removeAllObjects];
    [self.tableView reloadData];
    
    [self performSelector:@selector(startScan) withObject:nil afterDelay:RestartDelay];
}

- (void)startScan {
    [self.inputStickManager startBluetoothPeripheralScanWithTimeout:TRUE];
    [self.refreshControl endRefreshing];
}


- (void)prepareData {
    [_knownDevices removeAllObjects];
    [_unknownDevices removeAllObjects];
    
    for (InputStickPeripheralInfo *peripheralInfo in _inputStickManager.connectionManager.foundPeripherals) {
        if ([_inputStickManager.deviceDB hasDeviceWithIdentifier:peripheralInfo.identifier]) {
            [_knownDevices addObject:peripheralInfo];
        } else {
            [_unknownDevices addObject:peripheralInfo];
        }
    }
}

- (void)showBusyAccessory {
    [_cellActivityIndicatorView startAnimating];
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryNone;
    _statusTableViewCell.accessoryView = _cellActivityIndicatorView;
}

- (void)hideBusyAccessory {
    [_cellActivityIndicatorView stopAnimating];
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryNone;
    _statusTableViewCell.accessoryView = nil;
}

- (void)showDisclosureAccessory {
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryDetailButton;
    _statusTableViewCell.accessoryView = nil;
}

- (void)showCheckmarkAccessory {
    _statusTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _statusTableViewCell.accessoryView = nil;
}

- (void)popView {
    if (_done) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateUI {
    NSString *text;
    switch (_inputStickManager.connectionState) {
        case InputStickDisconnected:
            _selectedPeripheralInfo = nil;
            
            if (_scanning) {
                self.navigationItem.rightBarButtonItem = nil;
                [self showBusyAccessory];
                text = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_SCANNING", InputStickStringTable, nil);
            } else {
                self.navigationItem.rightBarButtonItem = _restartButton;
                [self hideBusyAccessory];
                if (([_unknownDevices count] == 0) && ([_knownDevices count] == 0)) {
                    [self showDisclosureAccessory];
                    text = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_NO_DEVICES_FOUND", InputStickStringTable, nil);
                } else {
                    text = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_SELECT_DEVICE", InputStickStringTable, nil);
                }
                
                
            }
            break;
        case InputStickConnecting:
            self.navigationItem.rightBarButtonItem = _cancelButton;
            [self showBusyAccessory];
            text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_CONNECTING", InputStickStringTable, nil);
            break;
        case InputStickInitializing:
            text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_INIT", InputStickStringTable, nil);
            break;
        case InputStickWaitingForUSB:
            text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_USB_NOT_READY", InputStickStringTable, nil);
            break;
        case InputStickReady:
            self.navigationItem.rightBarButtonItem = _disconnectButton;
            [self showCheckmarkAccessory];
            text = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_READY", InputStickStringTable, nil);
            //after state is set to InputStickReady it can switch between InputStickReady and InputStickWaitingForUSB
            if ( !_done) {
                _done = TRUE;
                [self performSelector:@selector(popView) withObject:nil afterDelay:CloseDelay];
            }
            break;
    }
    [_statusTableViewCell.textLabel setText:text];
}

@end

