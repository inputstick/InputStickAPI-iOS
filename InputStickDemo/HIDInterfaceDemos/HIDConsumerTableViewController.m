/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "HIDConsumerTableViewController.h"
#import "MainTableViewController.h"

#import "InputStickConsumerHandler.h"

#import "InputStickBarButtonItem.h"

static NSString *const CellReuseIdentifier = @"DemoConsumerCellIdentifier";


@implementation HIDConsumerTableViewController

#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Consumer control";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Media actions";
    } else {
        return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Mute";
            break;
        case 1:
            cell.textLabel.text = @"Vol+";
            break;
        case 2:
            cell.textLabel.text = @"Vol-";
            break;
        case 3:
            cell.textLabel.text = @"Play/pause";
            break;
        case 4:
            cell.textLabel.text = @"Prev track";
            break;
        case 5:
            cell.textLabel.text = @"Next track";
            break;
        case 6:
            cell.textLabel.text = @"Launch email client";
            break;
        case 7:
            cell.textLabel.text = @"Launch web browser";
            break;
        case 8:
            cell.textLabel.text = @"Launch calculator";
    }
    
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            //Mute (toggle)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionVolumeMute];
            break;
        case 1:
            //Vol+ (increase by 1 level, it is not possible to tell how many volume levels are between min (mute) and max, depends on OS/USB host)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionVolumeUp];
            break;
        case 2:
            //Vol- (decrease by 1 level, it is not possible to tell how many volume levels are between min (mute) and max, depends on OS/USB host)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionVolumeDown];
            break;
        case 3:
            //Play/pause
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionPlayPause];
            break;
        case 4:
            //Previous track
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionTrackPrevious];
            break;
        case 5:
            //Next track
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionTrackNext];
            break;
        case 6:
            //Launch email client (system default app)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionLaunchEmail];
            break;
        case 7:
            //Launch web browser (system default app)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionLaunchBrowser];
            break;
        case 8:
            //Launch calculator (system default app)
            [self.inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionLaunchCalc];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
