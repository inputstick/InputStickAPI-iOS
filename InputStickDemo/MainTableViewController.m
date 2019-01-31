/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "MainTableViewController.h"
#import "HIDKeyboardTableViewController.h"
#import "HIDMouseAndTouchScreenTableViewController.h"
#import "HIDConsumerTableViewController.h"
#import "HIDGamepadViewController.h"
#import "ConnectionTableViewController.h"
#import "CustomPacketTableViewController.h"
#import "HIDBuffersTableViewController.h"
#import "MousepadViewController.h"
#import "SoftKeyboardViewController.h"

#import "InputStickManager.h"
#import "InputStickPreferences.h"
#import "InputStickError.h"
#import "InputStickLog.h"
#import "InputStickConst.h"

#import "InputStickMenuTableViewController.h"
#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"

//#import "InputStickAPI.h"

static NSString *const CellReuseIdentifier = @"DemoMainCellIdentifier";


@interface MainTableViewController () {
    UIBackgroundTaskIdentifier _backgroundUpdateTask;
}

@end

/*
***********************************************************************************
************************************ IMPORTANT ************************************
***********************************************************************************
** When developing your own app using InputStickAPI:                             **
** make sure to include NSBluetoothPeripheralUsageDescription in Info.plist file **
***********************************************************************************
***********************************************************************************
*/


@implementation UINavigationController (overrides)

//do not allow to rotate when Gamepad demo is presented
- (BOOL)shouldAutorotate {
    if ([self.topViewController isKindOfClass:[HIDGamepadViewController class]]) {
        return NO;
    }
    return YES;
}
@end


@implementation MainTableViewController

static MainTableViewController *instance;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"InputStick Demo";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    //load InputStick preferences; skip this if you want to manage InputStick-related settings in your own code
    self.preferences = [[InputStickPreferences alloc] init];
    [self.preferences loadFromUserDefaults];
    //[InputStickLog printPreferences:_preferences];
    
    //InputStickManager allows to manage InputStick connection and access HID interface handlers (InputStickKeyboardHandler, InputStickMouseHandler etc.)
    self.inputStickManager = [[InputStickManager alloc] init];
    self.inputStickManager.delegate = self;
    
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    instance = self;
    [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveSelector)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignSelector)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    //if you want to take screenshots using iOS simulator device (which does not support Bluetooth):
    [self.inputStickManager addDummyDevice]; //make sure there is a device stored in database
    [self.inputStickManager setDummyConnectedState]; //pretend InputStick is connected
    //this won't have any effect when running on real device        
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.inputStickManager.delegate = self;    
}


#pragma mark - InputStickManager Delegate

- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error {
    NSLog(@"InputStick error: %@ (%ld)", error.localizedDescription, error.code);
    
    if (error.code == INPUTSTICK_ERROR_IOS_NO_DEVICES_STORED) {
        NSLog(@"handle no devices stored error");
        /*you can handle certain errors in a customized way, for example:
        if connection to most recently used device fails, because there are no previously connected devices stored in database
        show user how to manually connect to InputStick, in case of this demo:
        a) use InputStick Menu -> Connect (discover devices)
        b) use Custom Connection -> Connect (discover devices)
        do not show default error message!*/
    }
    
    UIAlertController *alertController = [InputStickUI errorAlertDialog:error];
    UIViewController *vc = [InputStickUI topViewControllerForRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [vc presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentKeyRemovedDialog:(InputStickDeviceData *)deviceData {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    UIAlertController *alertController = [InputStickUI keyRemovedAlertDialog:inputStickManager deviceData:deviceData];
    UIViewController *vc = [InputStickUI topViewControllerForRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [vc presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    UIAlertController *alertController = [InputStickUI provideKeyAlertDialog:inputStickManager deviceData:deviceData request:request];
    UIViewController *vc = [InputStickUI topViewControllerForRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [vc presentViewController:alertController animated:YES completion:nil];
}

- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    UIAlertController *alertController = [InputStickUI firmwareUpdateAlertDialog:inputStickManager deviceData:deviceData];
    UIViewController *vc = [InputStickUI topViewControllerForRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [vc presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 5;
    } else if (section == 3) {
        return 2;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Connection & Settings";
    } else if (section == 1) {
        return @"HID Interface Demos";
    } else if (section == 2) {
        return @"Advanced Demos";
    } else if (section == 3) {
        return @"More info";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        //Connection & Settings
        if (indexPath.section == 0) {
            cell.textLabel.text = @"InputStick Menu";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 1) {
        //HID demos
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Keyboard";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Mouse & Touch-screen";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Consumer control";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Gamepad";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 2) {
        //advanced
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Custom connection";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Type with soft keyboard";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Mousepad";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"HID Buffers";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"Custom packets";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 3) {
        //more info
        if (indexPath.row == 0) {
            cell.textLabel.text = @"http://inputstick.com";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"GitHub";
        }
    }
    
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    if (indexPath.section == 0) {
        //Connection & Settings
        if (indexPath.section == 0) {
            vc = [[InputStickMenuTableViewController alloc] init];
            ((InputStickMenuTableViewController *)vc).inputStickManager = self.inputStickManager;
            ((InputStickMenuTableViewController *)vc).preferences = self.preferences; //preferences will be updated when changed by user
            ((InputStickMenuTableViewController *)vc).hideBarButton = NO;  //will show InputStickBarButtonItem in InputStickMenu
        }
    } else if (indexPath.section == 1) {
        //HID demos
        if (indexPath.row == 0) {
            vc = [[HIDKeyboardTableViewController alloc] init];
            ((HIDKeyboardTableViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 1) {
            vc = [[HIDMouseAndTouchScreenTableViewController alloc] init];
            ((HIDMouseAndTouchScreenTableViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 2) {
            vc = [[HIDConsumerTableViewController alloc] init];
            ((HIDConsumerTableViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 3) {
            vc = [[HIDGamepadViewController alloc] init];
            ((HIDGamepadViewController *)vc).inputStickManager = self.inputStickManager;
        }
    } else if (indexPath.section == 2) {
        //advanced
        if (indexPath.row == 0) {
            vc = [[ConnectionTableViewController alloc] init];
            ((ConnectionTableViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 1) {
            vc = [[SoftKeyboardViewController alloc] init];
            ((SoftKeyboardViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 2) {
            vc = [[MousepadViewController alloc] init];
            ((MousepadViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 3) {
            vc = [[HIDBuffersTableViewController alloc] init];
            ((HIDBuffersTableViewController *)vc).inputStickManager = self.inputStickManager;
        } else if (indexPath.row == 4) {
            vc = [[CustomPacketTableViewController alloc] init];
            ((CustomPacketTableViewController *)vc).inputStickManager = self.inputStickManager;
        }
    } else if (indexPath.section == 3) {
        //more info
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:InputStickWebpageURL] options:@{} completionHandler:nil];
        } else if (indexPath.row == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/inputstick/"] options:@{} completionHandler:nil];
        }
    }
    
    if (vc != nil) {
        self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UIApplication Observer

- (void)appDidBecomeActiveSelector {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self endBackgroundUpdateTask];
    
    //[self.preferences loadValueForSettingsItem:InputStickSettingsItemAutoConnect]; //reload in case settings were changed
    //in this case it is not necessary: InputStickMenu will reload preferences if auto-connect (or anything else) is changed
    
    //optionally (if enabled in settings) auto-connect now (will NOT auto-connect if previous connection attempt failed, as a failsafe)
    if (self.preferences.autoConnect && self.inputStickManager.connectionState == InputStickDisconnected) {
        [self.inputStickManager autoConnectLastInputStick];
    }
}

- (void)appWillResignSelector {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //prepare to release connection if app won't become active soon
    [self beginBackgroundUpdateTask];
}

- (void)beginBackgroundUpdateTask {
    _backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        if (self.inputStickManager != nil) {
            if ( !self.inputStickManager.inputStickDicsonnected) {
                [self.inputStickManager disconnectFromInputStick];
            }
        }
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask {
    [[UIApplication sharedApplication] endBackgroundTask: _backgroundUpdateTask];
    _backgroundUpdateTask = UIBackgroundTaskInvalid;
}


#pragma mark - InputStickConnectionNotification Observer

-(void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    //get current connection state from notification:
    /*NSNumber *tmp = (NSNumber *)notification.userInfo[InputStickNotificationConnectionStateKey];
    InputStickConnectionState state = tmp.unsignedIntegerValue; */
    
    //or from inputStickManager:
    InputStickConnectionState state = self.inputStickManager.connectionState;
    NSLog(@"InputStick connection state: %@", [InputStickUI nameForInputStickConnectionState:state]);
    
    //you can also check here if an error has occurred:
    /*NSError *error = self.inputStickManager.lastError;
    if (error) {
        NSString *desc = error.localizedDescription;
        NSInteger code = error.code;
    }*/
    //or handle errors in:
    //inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error
    
    switch (state) {
        case InputStickDisconnected:
            [self setTitle:@"InputStick Demo"];
            break;
        case InputStickConnecting:
        case InputStickInitializing:
        case InputStickWaitingForUSB:
            [self setTitle:@"Connecting..."];
            break;
        case InputStickReady:
            [self setTitle:@"Connected"];
            break;
    }
}


#pragma mark - static methods

//just another way to get InputStickManager and interface handlers
+ (InputStickManager *)getInputStickManager {
    return instance.inputStickManager;
}

@end
