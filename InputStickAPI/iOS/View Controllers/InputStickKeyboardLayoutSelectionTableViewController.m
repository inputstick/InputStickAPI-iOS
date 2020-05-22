/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import "InputStickKeyboardLayoutSelectionTableViewController.h"
#import "InputStickKeyboardLayoutUtils.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickConst.h"
#import "InputStickTheme.h"

static NSString *const CellReuseIdentifier = @"InputStickSettingsKeyboardLayoutSelectionCellIdentifier";


@interface InputStickKeyboardLayoutSelectionTableViewController () {
    NSIndexPath *_selectedItemIndexPath;
    NSMutableArray *_layoutGroups;
    NSMutableArray *_headers;
    NSMutableArray *_footers;
}

@end


@implementation InputStickKeyboardLayoutSelectionTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithKey:(NSString *)key userDefaults:(NSUserDefaults *)userDefaults languageCode:(NSString *)languageCode {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.userDefaults = userDefaults;
        self.key = key;
        
        _layoutGroups = [[NSMutableArray alloc] init];
        _headers = [[NSMutableArray alloc] init];
        _footers = [[NSMutableArray alloc] init];
        
        NSString *selectedLayoutCode = [self.userDefaults objectForKey:key];
        NSUInteger section = 0;
        NSUInteger row = 0;
        
        NSArray *groupCodes = [InputStickKeyboardLayoutUtils groupCodesWithLanguageCode:languageCode];
        for (NSString *groupCode in groupCodes) {
            NSArray<id <InputStickKeyboardLayoutProtocol>> *layoutGroup = [InputStickKeyboardLayoutUtils keyboardLayoutsWithCodePrefix:groupCode];
            [_layoutGroups addObject:layoutGroup];
            [_headers addObject:[InputStickKeyboardLayoutUtils groupNameWithGroupCode:groupCode]];
            [_footers addObject:[InputStickKeyboardLayoutUtils groupInfoWithGroupCode:groupCode]];
            
            //search for selectedLayoutCode to determine its index
            for (id <InputStickKeyboardLayoutProtocol> layout in layoutGroup) {
                if ([[layout layoutCode] isEqualToString:selectedLayoutCode]) {
                    _selectedItemIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
                }
                row++;
            }
            section++;
        }
        
        [self setTitle:NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_KEYBOARD_LAYOUT", InputStickStringTable, nil)];
    }
    return self;
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
    return [_layoutGroups count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tmp = [_layoutGroups objectAtIndex:section];
    return [tmp count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_headers objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_footers objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    [InputStickTheme themeTableViewCell:cell];
    
    NSArray *tmp = [_layoutGroups objectAtIndex:indexPath.section];
    id <InputStickKeyboardLayoutProtocol> layout = [tmp objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [layout layoutEnglishName], [layout layoutVariant]];
    
    if ([indexPath compare:_selectedItemIndexPath] == NSOrderedSame) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    NSArray *tmp = [_layoutGroups objectAtIndex:indexPath.section];
    id <InputStickKeyboardLayoutProtocol> layout = [tmp objectAtIndex:indexPath.row];
    [self.userDefaults setObject:[layout layoutCode] forKey:self.key];
    [self.userDefaults synchronize];
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    if (_selectedItemIndexPath != nil) {
        [tableView cellForRowAtIndexPath:_selectedItemIndexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    _selectedItemIndexPath = indexPath;
        
    //there is another Settings UIViewController (InputStickKeyboardLanguageSelectionTableViewController) in stack; pop 2 view controllers
    NSMutableArray *viewControllersStack = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    if ([viewControllersStack count] >= 3) { //failsafe:
        UIViewController *targetViewController = [viewControllersStack objectAtIndex:([viewControllersStack count] - 3)];
        [self.navigationController popToViewController:targetViewController animated:NO];
    }
}

@end
