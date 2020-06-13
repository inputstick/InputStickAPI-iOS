/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickDeviceSelectionTableViewController.h"
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


@interface InputStickDeviceSelectionTableViewController () {
    InputStickPeripheralInfo *_selectedPeripheralInfo;
    UITableViewCell *_statusTableViewCell;
    UIActivityIndicatorView *_cellActivityIndicatorView;
    UIBarButtonItem *_restartButton;
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_disconnectButton;
    
    NSMutableArray<InputStickPeripheralInfo *> *_knownDevices; //discovered peripherals that were previously connected to (stored in DB)
    NSMutableArray<InputStickPeripheralInfo *> *_unknownDevices; //discovered peripherals thet were never connected to

    BOOL _scanning;
    BOOL _restarting;
    BOOL _done;
}

@end


@implementation InputStickDeviceSelectionTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)manager {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _inputStickManager = manager;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self]; //pre iOS9
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickPeripheralScanNotificationsWithObserver:self]; //pre iOS9
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TITLE", InputStickStringTable, nil);
    //do not registerClass forCellReuseIdentifier! we need UITableViewCellStyleValue1! for section 0, row 0 see cellForRowAtIndexPath
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellStatusReuseIdentifier];
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
    
    if (@available(iOS 13, *)) {
        _cellActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    } else {
        _cellActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    //pull down to force-restart BT scan
    if (@available(iOS 10, *)) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_PULL_DOWN_TO_RESTART", InputStickStringTable, nil)];
        [self.refreshControl addTarget:self action:@selector(restartScan) forControlEvents:UIControlEventValueChanged];
        [InputStickTheme themeRefreshControl:self.refreshControl];
    }
    
    [InputStickTheme themeActivityIndicatorView:_cellActivityIndicatorView];
    [InputStickTheme themeViewController:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
    [[NSNotificationCenter defaultCenter] registerForInputStickPeripheralScanNotificationsWithObserver:self];
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


#pragma mark - UIApplication Notifications

- (void)appDidBecomeActive {
    [self restartScan];
}

- (void)appWillResignActive {
    [self.inputStickManager stopBluetoothPeripheralScan];
}


#pragma mark - InputStickManager Delegate

- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error {
    UIAlertController *alertController = [InputStickUI errorAlertDialog:inputStickManager error:error];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)inputStickManager:(InputStickManager *)inputStickManager presentEncryptionKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    UIAlertController *alertController = [InputStickUI encryptionKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    [self presentViewController:alertController animated:YES completion:nil];
    return TRUE;
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData viewController:self];
    [self presentViewController:alertController animated:YES completion:nil];
    _done = FALSE; //do not pop view controller
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger sections = 1;
    if ([_knownDevices count] > 0) {
        sections++;
    }
    if ([_unknownDevices count] > 0) {
        sections++;
    }
    return sections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        if ([_knownDevices count] > 0) {
            return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_SAVED_DEVICES", InputStickStringTable, nil);
        } else {
            return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_NEARBY_DEVICES", InputStickStringTable, nil);
        }
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
        if ([_knownDevices count] > 0) {
            return [_knownDevices count];
        } else {
            return [_unknownDevices count];
        }
    } else if (section == 2) {
        return [_unknownDevices count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _statusTableViewCell = cell;
        _statusTableViewCell.textLabel.textColor = [InputStickUI labelColor];
        [_statusTableViewCell setUserInteractionEnabled:NO]; //important! set color first!
        [self updateUI];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellDeviceReuseIdentifier forIndexPath:indexPath];
    }
    [InputStickTheme themeTableViewCell:cell];
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
        if ([_knownDevices count] > 0) {
            peripheralInfo = _knownDevices[(NSUInteger)indexPath.item];
        } else {
            peripheralInfo = _unknownDevices[(NSUInteger)indexPath.item];
        }
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
            if ([_knownDevices count] > 0) {
                _selectedPeripheralInfo = _knownDevices[(NSUInteger) indexPath.item];
                [self.inputStickManager connectToInputStickWithIdentifier:_selectedPeripheralInfo.identifier];
            } else {
                _selectedPeripheralInfo = _unknownDevices[(NSUInteger) indexPath.item];
                [self.inputStickManager connectToInputStickWithIdentifier:_selectedPeripheralInfo.identifier];
            }
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

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    //InputStickConnectionState state = _inputStickManager.connectionState;
    if (self.inputStickManager.lastError != nil) {
        _done = FALSE; //lost connection before view controller got popped
    }
    [self updateUI];
}


#pragma mark - InputStickPeripheralScanNotification Observer


- (void)didStartInputStickPeripheralScan {
    _restarting = FALSE;
    _scanning = TRUE;
    [self updateUI];
}

- (void)didFinishInputStickPeripheralScan {
    if ( !_restarting) {
        _scanning = FALSE;
        [self updateUI];
    }
}

- (void)didTimeoutInputStickPeripheralScan {
}

- (void)didUpdateInputStickPeripheralsList:(NSNotification *)notification {
    [self prepareData];
    [self.tableView reloadData];
}


#pragma mark - UI

- (void)disconnect {
    [_inputStickManager disconnectFromInputStick];
}


- (void)restartScan {
    _scanning = TRUE;
    _restarting = TRUE;
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
    NSString *title;
    NSString *detail;
    switch (_inputStickManager.connectionState) {
        case InputStickDisconnected:
            _selectedPeripheralInfo = nil;
            
            if (_scanning) {
                self.navigationItem.rightBarButtonItem = nil;
                [self showBusyAccessory];
                title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
                detail = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_SCANNING", InputStickStringTable, nil);
            } else {
                self.navigationItem.rightBarButtonItem = _restartButton;
                [self hideBusyAccessory];
                if (([_unknownDevices count] == 0) && ([_knownDevices count] == 0)) {
                    [self showDisclosureAccessory];
                    title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_NO_DEVICES_FOUND", InputStickStringTable, nil);
                    detail = nil;
                } else {
                    title = NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_SELECT_DEVICE", InputStickStringTable, nil);
                    detail = nil;
                }
                
                
            }
            break;
        case InputStickConnecting:
            self.navigationItem.rightBarButtonItem = _cancelButton;
            [self showBusyAccessory];
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_CONNECTING", InputStickStringTable, nil);
            break;
        case InputStickInitializing:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_INIT", InputStickStringTable, nil);
            break;
        case InputStickWaitingForUSB:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_USB_NOT_READY", InputStickStringTable, nil);
            break;
        case InputStickReady:
            self.navigationItem.rightBarButtonItem = _disconnectButton;
            [self showCheckmarkAccessory];
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_READY", InputStickStringTable, nil);
            //after state is set to InputStickReady it can switch between InputStickReady and InputStickWaitingForUSB
            if ( !_done) {
                _done = TRUE;
                [self performSelector:@selector(popView) withObject:nil afterDelay:CloseDelay];
            }
            break;
    }
    //[_statusTableViewCell.textLabel setText:text];
    _statusTableViewCell.textLabel.text = title;
    _statusTableViewCell.detailTextLabel.text = detail;
}

@end

