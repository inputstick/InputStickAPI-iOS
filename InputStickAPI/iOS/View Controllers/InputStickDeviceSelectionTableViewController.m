/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickDeviceSelectionTableViewController.h"
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
    //[self.tableView registerClass:[InputStickDeviceTableViewCell class] forCellReuseIdentifier:CellDeviceReuseIdentifier];
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

- (void)inputStickManager:(InputStickManager *)inputStickManager presentUSBResumeDialog:(InputStickDeviceData *)deviceData {
    UIAlertController *alertController = [InputStickUI usbResumeAlertDialog:inputStickManager deviceData:deviceData viewController:self];
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
            return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_MY_DEVICES", InputStickStringTable, nil);
        } else {
            return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_DEVICES", InputStickStringTable, nil);
        }
    } else if (section == 2) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TABLE_SECTION_OTHER_DEVICES", InputStickStringTable, nil);
    }
    return [super tableView:tableView titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_FOOTER_INFO", InputStickStringTable, nil);
    }
    return [super tableView:tableView titleForFooterInSection:section];
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
        _statusTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [InputStickTheme themeTableViewCell:cell];
        
        [self updateStatusCell];
    } else { //section 1/ section 2
        cell = [tableView dequeueReusableCellWithIdentifier:CellDeviceReuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellDeviceReuseIdentifier];
            [InputStickTheme themeTableViewCell:cell];
        }
        
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
            [self updateDeviceInfoCell:cell withPeripheralInfo:peripheralInfo];
        }
    }
    
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        [InputStickTheme themeTableViewHeaderView:(UITableViewHeaderFooterView *)view];
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
    if (indexPath.section == 0 && indexPath.row == 0) {        
        [InputStickUI showAlertWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_DIALOG_TITLE_HELP", InputStickStringTable, nil)
                                 message:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_DIALOG_TEXT_HELP", InputStickStringTable, nil)
                                     url:[NSURL URLWithString:InputStickWebpageHelpURL]
                          viewController:self];
    }
}


#pragma mark - InputStickConnectionNotification Observer

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    if (self.inputStickManager.lastError != nil) {
        _done = FALSE; //lost connection before view controller got popped
    }
    [self updateStatusCell];
}


#pragma mark - InputStickPeripheralScanNotification Observer


- (void)didStartInputStickPeripheralScan {
    _restarting = FALSE;
    _scanning = TRUE;
    [self updateStatusCell];
}

- (void)didFinishInputStickPeripheralScan {
    if ( !_restarting) {
        _scanning = FALSE;
        [self updateStatusCell];
    }
}

- (void)didTimeoutInputStickPeripheralScan {
}

- (void)didUpdateInputStickPeripheralsList:(NSNotification *)notification {
    [self prepareData];
    [self.tableView reloadData];
}


#pragma mark - Scan

- (void)disconnect {
    [_inputStickManager disconnectFromInputStick];
}


- (void)restartScan {
    _scanning = TRUE;
    _restarting = TRUE;
    [self updateStatusCell]; //force UI update before scan is started (after RestartDelay)
    
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


#pragma mark - UI

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

- (void)showDetailAccessory {
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

- (void)updateStatusCell {
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
                [self showDetailAccessory];
                if (([_unknownDevices count] == 0) && ([_knownDevices count] == 0)) {
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
        case InputStickUSBNotReady:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_USB_NOT_READY", InputStickStringTable, nil);
            break;
        case InputStickUSBSuspended:
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_USB_SUSPENDED", InputStickStringTable, nil);
            break;
        case InputStickReady:
            self.navigationItem.rightBarButtonItem = _disconnectButton;
            [self showCheckmarkAccessory];
            title = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_TEXT_STATUS", InputStickStringTable, nil);
            detail = NSLocalizedStringFromTable(@"INPUTSTICK_STATUS_READY", InputStickStringTable, nil);
            //after state is set to InputStickReady it can switch between InputStickReady / InputStickUSBNotReady / InputStickUSBSuspended
            if ( !_done) {
                _done = TRUE;
                [self performSelector:@selector(popView) withObject:nil afterDelay:CloseDelay];
            }
            break;
    }
    
    _statusTableViewCell.textLabel.text = title;
    _statusTableViewCell.detailTextLabel.text = detail;
}

- (void)updateDeviceInfoCell:(UITableViewCell *)cell withPeripheralInfo:(InputStickPeripheralInfo *)peripheralInfo {
    NSMutableAttributedString *nameAttributedString;
    if (peripheralInfo.peripheral.name != nil) {
        nameAttributedString = [[NSMutableAttributedString alloc] initWithString:peripheralInfo.peripheral.name];
    } else {
        nameAttributedString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"INPUTSTICK_DEVICE_SELECTION_TEXT_UNKNOWN_DEVICE", InputStickStringTable, nil)];
    }
    if ([peripheralInfo.peripheral.name isEqualToString:InputStickBluetoothDefaultName]) {
        //mark the devices name with blue color, it is almost 100% InputStick (BT SSID == "InputStick")
        [nameAttributedString addAttribute:NSFontAttributeName
                                     value:[UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize]
                                     range:NSMakeRange(0, nameAttributedString.length)];
        [nameAttributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                                     range:NSMakeRange(0, nameAttributedString.length)];
    }
    InputStickDeviceData *deviceData = [_inputStickManager.deviceDB getDataForDeviceWithIdentifier:peripheralInfo.identifier];
    if (deviceData != nil) {
        NSMutableAttributedString *dbNameAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" (%@)", deviceData.name]];
        [nameAttributedString appendAttributedString:dbNameAttributedString];
    }
    cell.textLabel.attributedText = nameAttributedString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"UUID: %@", peripheralInfo.identifier];
}

@end

