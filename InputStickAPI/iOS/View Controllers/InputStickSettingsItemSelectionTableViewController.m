/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickSettingsItemSelectionTableViewController.h"
#import "InputStickTheme.h"

static NSString *const CellReuseIdentifier = @"InputStickSettingsItemSelectionCellIdentifier";


@interface InputStickSettingsItemSelectionTableViewController () {
    BOOL _detailedMode; //when in detailed mode: use sections & display info text in footers
    NSInteger _checkedIndex;
}

@end


@implementation InputStickSettingsItemSelectionTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems storeValues:(NSArray<NSString *> *)storeValues infoItems:(NSArray<NSString *> *)infoItems userDefaults:(NSUserDefaults *)userDefaults subLevel:(BOOL)subLevel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.userDefaults = userDefaults;
        self.subLevel = subLevel;
                
        self.key = key;
        self.displayItems = displayItems;
        self.storeValues = storeValues;
        self.infoItems = infoItems;
        
        
        if (self.infoItems == nil) {
            _detailedMode = FALSE;
        } else {
            _detailedMode = TRUE;
        }
        
        [self setTitle:title];
        
        NSString *tmp = [self.userDefaults objectForKey:key];
        _checkedIndex = -1;
        if ([self.storeValues containsObject: tmp]) {
            _checkedIndex = [self.storeValues indexOfObject:tmp];
        }
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems storeValues:(NSArray<NSString *> *)storeValues userDefaults:(NSUserDefaults *)userDefaults {
    return [self initWithTitle:title
                           key:key
                  displayItems:displayItems
                   storeValues:storeValues
                     infoItems:nil
                  userDefaults:userDefaults
                      subLevel:FALSE];
}

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key displayItems:(NSArray<NSString *> *)displayItems infoItems:(NSArray<NSString *> *)infoItems storeValues:(NSArray<NSString *> *)storeValues userDefaults:(NSUserDefaults *)userDefaults {
    return [self initWithTitle:title
                           key:key
                  displayItems:displayItems
                   storeValues:storeValues
                     infoItems:infoItems
                  userDefaults:userDefaults
                      subLevel:FALSE];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //empty cells will not be displayed
    [InputStickTheme themeViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_detailedMode) {
        return [self.displayItems count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_detailedMode) {
        return 1;
    } else {
        return [self.displayItems count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (_detailedMode) {
        return [self.infoItems objectAtIndex:section];
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    [InputStickTheme themeTableViewCell:cell];
    
    NSUInteger index = 0;
    if (_detailedMode) {
        index = indexPath.section;
    } else {
        index = indexPath.row;
    }
    cell.textLabel.text = [self.displayItems objectAtIndex:index];
    if (index == _checkedIndex) {
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
    NSUInteger index;
    NSIndexPath *tmp;
    if (_detailedMode) {
        index = indexPath.section;
        tmp = [NSIndexPath indexPathForRow:0 inSection:_checkedIndex];
    } else {
        index = indexPath.row;
        tmp = [NSIndexPath indexPathForRow:_checkedIndex inSection:0];
    }
    NSString *value = [self.storeValues objectAtIndex:index];
    [self.userDefaults setObject:value forKey:self.key];
    [self.userDefaults synchronize];
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    if (_checkedIndex >= 0) {
        [tableView cellForRowAtIndexPath:tmp].accessoryType = UITableViewCellAccessoryNone;
    }
    _checkedIndex = index;
        
    if (self.subLevel) {
        //there is another Settings UIViewController (KeyboardLanguage etc.) pop 2 view controllers 
        NSMutableArray *viewControllersStack = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
        if ([viewControllersStack count] >= 3) { //failsafe:
            UIViewController *targetViewController = [viewControllersStack objectAtIndex:([viewControllersStack count] - 3)];
            [self.navigationController popToViewController:targetViewController animated:NO];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
