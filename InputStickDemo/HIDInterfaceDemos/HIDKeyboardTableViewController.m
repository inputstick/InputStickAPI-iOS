/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "HIDKeyboardTableViewController.h"
#import "MainTableViewController.h"

#import "InputStickManager.h"
#import "InputStickHIDTransaction.h"
#import "InputStickKeyboardHandler.h"
#import "InputStickKeyboardLEDsState.h"
#import "InputStickKeyboardUtils.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickPreferences.h"

#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"


static NSString *const CellReuseIdentifier = @"DemoKeyboardCellIdentifier";
static NSString *const DemoText1 = @"InputStick Demo text\nAlways make sure that keyboard layouts used by app and USB host are identical\n";
static NSString *const DemoText2 = @"Connected & Ready";


@interface HIDKeyboardTableViewController () {
    id <InputStickKeyboardLayoutProtocol> _layout;
}

@end


@implementation HIDKeyboardTableViewController

- (id)init {
    self = [super init];
    if (self) {
        //if you use settings managed by InputStickAPI:
        InputStickPreferences *preferences = [[InputStickPreferences alloc] init];
        [preferences loadFromUserDefaults];
        _layout = preferences.keyboardLayout; //use keyboard layout set in preferences
        
        //if you manage settings in your own code, provide values for keyboard layout, typing speed etc.
        //_layout = [InputStickKeyboardUtils keyboardLayoutWithCode:layoutCode];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] registerForInputStickStatusUpdateNotificationsWithObserver:self]; //HID buffers + LEDs updates
    
    self.title = @"Keyboard";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells  
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - InputStickStatusUpdateNotificationObserver

//called approximately every 500ms (firmware 1.0 and later) or 100ms (before 1.0)
- (void)didUpdateInputStickKeyboardLEDsNotification:(NSNotification *)notification {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //you can get LEDs state from notification:
    //InputStickKeyboardLEDsState *keyboardLEDsState = notification.userInfo[InputStickNotificationKeyboardLEDsKey];
    //or: self.inputStickManager.keyboardHandler.numLockOn etc.
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2; //status & layout info
    } else {
        return 12; //demo actions
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Status";
    } else if (section == 1) {
        return @"Keyboard actions";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *statusInfo = @"LEDs: ";
            
            if (self.inputStickManager.inputStickReady) {
                if (self.inputStickManager.keyboardHandler.numLockOn) {
                    statusInfo = [statusInfo stringByAppendingString:@"[NumLock]"];
                }
                if (self.inputStickManager.keyboardHandler.capsLockOn) {
                    statusInfo = [statusInfo stringByAppendingString:@"[CapsLock]"];
                }
                if (self.inputStickManager.keyboardHandler.scrollLockOn) {
                    statusInfo = [statusInfo stringByAppendingString:@"[ScrollLock]"];
                }
            } else {
                statusInfo = [statusInfo stringByAppendingString:@"N/A"];
            }
            
            cell.textLabel.text = statusInfo;
        } else {
            NSString *layoutInfo = [NSString stringWithFormat:@"Layout: %@", [[_layout class] layoutCode]];
            cell.textLabel.text = layoutInfo;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Press and release \"Z\" key";
                break;
            case 1:
                cell.textLabel.text = @"Press and HOLD \"Z\" key";
                break;
            case 2:
                cell.textLabel.text = @"Release all keys";
                break;
            case 3:
                cell.textLabel.text = @"Ctrl+Alt+Delete";
                break;
            case 4:
                cell.textLabel.text = @"CapsLock";
                break;
            case 5:
                cell.textLabel.text = @"Type demo text (normal)";
                break;
            case 6:
                cell.textLabel.text = @"Type demo text (slow)";
                break;
            case 7:
                cell.textLabel.text = @"Type demo text (fastest)";
                break;
            case 8:
                cell.textLabel.text = @"Queue keyboard actions";
                break;
            case 9:
                cell.textLabel.text = @"HID Transaction";
                break;
            case 10:
                cell.textLabel.text = @"Cancel typing";
                break;
            case 11:
                cell.textLabel.text = @"Check connection & Type text";
                break;
        }
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                //Press and release Z key
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_Z];
                break;
            case 1:
                //Press and HOLD Z key;
                //Note: after sending this report, report queue will be empty:
                //self.main.inputStickManager.blueToothBuffer isKeyboardBufferEmpty
                //will return TRUE, but the "Z" key will still be pressed and "z" characters will continue to appear in text editor
                //send pressKeyAndReleaseWithModifiers:0 key:0 to release all keys
                [self.inputStickManager.keyboardHandler sendCustomReportWithModifiers:0 key:KEY_Z flush:TRUE];
                break;
            case 2:
                //Release all keys
                [self.inputStickManager.keyboardHandler sendCustomReportWithModifiers:0 key:0 flush:TRUE];
                break;
            case 3:
                //Ctrl+Alt+Delete
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:(CTRL_LEFT | ALT_LEFT) withKey:KEY_DELETE];
                break;
            case 4:
                //CapsLock
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_CAPS_LOCK];
                break;
            case 5:
                //Type demo text (normal)
                [self.inputStickManager.keyboardHandler typeText:DemoText1 withKeyboardLayout:_layout];
                break;
            case 6:
                //Type demo text (slow)
                [self.inputStickManager.keyboardHandler typeText:DemoText1 withKeyboardLayout:_layout typingSpeed:5];
                break;
            case 7:
                //Type demo text (fastest)
                [self.inputStickManager.keyboardHandler typeText:DemoText1 withKeyboardLayout:_layout typingSpeed:0];
                break;
            case 8:
                //Queue keyboard actions
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_A flush:FALSE];
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_B flush:FALSE];
                [NSThread sleepForTimeInterval:1.0];
                [self.inputStickManager.keyboardHandler typeText:@"1234567890" withKeyboardLayout:_layout modifiers:0 typingSpeed:1 flush:FALSE];
                [NSThread sleepForTimeInterval:1.0];
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_C flush:FALSE];
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:KEY_D flush:FALSE];
                //no text will be typed until keyboard buffer is manually flushed or a method with flush:TRUE is called
                [self.inputStickManager flushKeyboardBuffer];
                break;
            case 9:
                //HID Transaction
                {
                    //guarantees that all reports will be sent in a single packet (unless number of reports exceeds max reports/packet)
                    //either all 4 characters will be typed ("abcd") or none of them (in case Bluetooth connection is lost)
                    InputStickHIDTransaction *transaction = [InputStickHIDTransaction shortKeyboardTransaction];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_A]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_NONE]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_B]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_NONE]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_C]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_NONE]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_D]];
                    [transaction addHIDReport:[self.inputStickManager.keyboardHandler customReportWithModifiers:0x00 key:KEY_NONE]];
                    [self.inputStickManager addKeyboardHIDTransaction:transaction flush:YES];
                }
                break;
            case 10:
                //Cancel typing
                [self.inputStickManager clearKeyboardBuffer];
                [self.inputStickManager.keyboardHandler pressAndReleaseModifiers:0 withKey:0 flush:YES]; //make sure to release all keys
                break;
            case 11:
                //Check connection & Type text
                //error message will be displayed if typing is not possible (not connected etc.)
                if ([InputStickUI checkIfInputStickIsReady:self.inputStickManager viewController:self]) {
                    [self.inputStickManager.keyboardHandler typeText:DemoText2 withKeyboardLayout:_layout];
                }
                //or if you want to handle dialogs yourself:
                /*if (self.inputStickManager.inputStickReady) {\
                    [self.inputStickManager.keyboardHandler typeText:DEMO_TEXT2 withKeyboardLayout:_layout];
                } else {
                    //handle case when not ready
                }*/
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
