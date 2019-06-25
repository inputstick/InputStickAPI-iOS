/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "HIDMouseAndTouchScreenTableViewController.h"

#import "InputStickManager.h"
#import "InputStickMouseHandler.h"
#import "InputStickTouchScreenHandler.h"
#import "InputStickHIDBuffersManager.h"

#import "InputStickBarButtonItem.h"

static NSString *const CellReuseIdentifier = @"DemoMouseTouchScreenCellIdentifier";


@implementation HIDMouseAndTouchScreenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mouse & Touch-screen";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes empty cells
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 4;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Mouse actions";
    } else if (section == 1) {
        return @"Touch-screen actions";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Move";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"2x Click";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Scroll up";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Drag";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Touch (move to)";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Press (click)";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Drag";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Go out of range";
        }
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //mouse: move cursor
            [self.inputStickManager.mouseHandler moveCursorByX:20 y:10];
        } else if (indexPath.row == 1) {
            //mouse: 2x click
            [self.inputStickManager.mouseHandler clickWithButtons:MouseButtonLeft numberOfPress:2];
        } else if (indexPath.row == 2) {
            //mouse: scroll up
            [self.inputStickManager.mouseHandler scroll:5];
        } else if (indexPath.row == 3) {
            //mouse: drag
            [self.inputStickManager.mouseHandler sendCustomReportWithButtons:MouseButtonLeft x:0 y:0 scroll:0 flush:NO]; //press left mouse button
            [self.inputStickManager.mouseHandler sendCustomReportWithButtons:MouseButtonLeft x:0 y:50 scroll:0 flush:NO]; //move (keep pressed)
            [self.inputStickManager.mouseHandler sendCustomReportWithButtons:MouseButtonNone x:0 y:0 scroll:0 flush:NO]; //release left mouse button
            [self.inputStickManager.buffersManager flushMouseBuffer];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //touch-screen: touch screen center (move to)
            //0 = 0%, 10000 = 100% -> 5000,5000 = 50% screen width / 50% screen height
            [self.inputStickManager.touchScreenHandler moveTouchPointerToX:5000 y:5000 withButtonPressed:NO];
        } else if (indexPath.row == 1) {
            //touch-screen: press screen center (click)
            [self.inputStickManager.touchScreenHandler moveTouchPointerToX:5000 y:5000 withButtonPressed:YES];
            [self.inputStickManager.touchScreenHandler moveTouchPointerToX:5000 y:5000 withButtonPressed:NO];
        } else if (indexPath.row == 2) {
            //touch-screen: drag
            [self.inputStickManager.touchScreenHandler sendCustomReportWithTipSwitch:YES inRange:YES x:5000 y:5000 flush:NO]; //press
            [self.inputStickManager.touchScreenHandler sendCustomReportWithTipSwitch:YES inRange:YES x:5000 y:6000 flush:NO]; //move (while still pressed)
            [self.inputStickManager.touchScreenHandler sendCustomReportWithTipSwitch:NO inRange:YES x:5000 y:6000 flush:NO]; //release
            [self.inputStickManager.buffersManager flushConsumerBuffer]; //touch-screen sends data via Consumer Control interface!!!
        } else if (indexPath.row == 3) {
            //touch-screen: go out of range (lift finger)
            //OS should hide touch-screen UI
            [self.inputStickManager.touchScreenHandler goOutOfRangeAtX:5000 y:5000];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
