/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickSettingsItemSelectionTableViewController.h"
#import "InputStickTheme.h"

static NSString *const CellReuseIdentifier = @"InputStickSettingsItemSelectionCellIdentifier";


@interface InputStickSettingsItemSelectionTableViewController () {
    NSInteger _checkedRow;
}

@end


@implementation InputStickSettingsItemSelectionTableViewController

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayValues storeValues:(NSArray<NSString *> *)storeValues {
    self = [super init];
    if (self) {
        self.key = key;
        self.displayValues = displayValues;
        self.storeValues = storeValues;
        
        [self setTitle:title];
        
        NSString *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if ([self.storeValues containsObject: tmp]) {
            _checkedRow = [self.storeValues indexOfObject:tmp];
        } else {
            _checkedRow = -1;
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //empty cells will not be displayed
    [InputStickTheme themeViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.displayValues count];
}


#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    [InputStickTheme themeTableViewCell:cell];
    
    cell.textLabel.text = [self.displayValues objectAtIndex:indexPath.row];
    if (indexPath.row == _checkedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    NSString *value = [self.storeValues objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];    
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    if (_checkedRow >= 0) {
        NSIndexPath *tmp = [NSIndexPath indexPathForRow:_checkedRow inSection:0];
        [tableView cellForRowAtIndexPath:tmp].accessoryType = UITableViewCellAccessoryNone;
    }
    _checkedRow = indexPath.row;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
