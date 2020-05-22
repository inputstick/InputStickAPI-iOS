/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import "InputStickKeyboardLanguageSelectionTableViewController.h"
#import "InputStickKeyboardLayoutSelectionTableViewController.h"
#import "InputStickKeyboardLayoutUtils.h"
#import "InputStickPreferences.h"
#import "InputStickPreferencesHelper.h"
#import "InputStickConst.h"
#import "InputStickTheme.h"

static NSString *const CellReuseIdentifier = @"InputStickSettingsKeyboardLanguageSelectionCellIdentifier";


@interface InputStickKeyboardLanguageSelectionTableViewController () {
    NSArray<NSString *> *_languageNames;
    NSArray<NSString *> *_languageCodes;
    NSInteger _checkedIndex;
    NSString *_currentlySelectedLayoutName;
}

@end


@implementation InputStickKeyboardLanguageSelectionTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults {
    self = [super init];
    if (self) {
        _userDefaults = userDefaults;
        
        _languageNames = [InputStickKeyboardLayoutUtils keyboardLayoutLanguageNames];
        _languageCodes = [InputStickKeyboardLayoutUtils keyboardLayoutLanguageCodes];
        
        NSString *tmp = [_userDefaults objectForKey:InputStickSettingsKeyboardLayoutKey];
        tmp = [tmp substringToIndex:2];
        _checkedIndex = -1;
        if ([_languageCodes containsObject: tmp]) {
            _checkedIndex = [_languageCodes indexOfObject:tmp];
            _currentlySelectedLayoutName = [InputStickPreferencesHelper displayValueForItem:InputStickSettingsItemKeyboardLayout userDefaults:_userDefaults];
        }
        
        [self setTitle:NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_KEYBOARD_LANGUAGE", InputStickStringTable, nil)];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:NSLocalizedStringFromTable(@"INPUTSTICK_BUTTON_BACK", InputStickStringTable, nil)
                                       style:UIBarButtonItemStylePlain
                                       target:nil
                                       action:nil
                                       ];
        self.navigationItem.backBarButtonItem = backButton;
    }
    
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //empty cells will not be displayed
    [InputStickTheme themeViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_languageNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellReuseIdentifier];
    }
    [InputStickTheme themeTableViewCell:cell];
    
    NSUInteger index = indexPath.row;
    NSString *name = [_languageNames objectAtIndex:index];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (index == _checkedIndex) {
        NSString *selectedLayoutInfo = NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TEXT_SELECTED_LAYOUT", InputStickStringTable, nil);
        selectedLayoutInfo = [selectedLayoutInfo stringByAppendingString:_currentlySelectedLayoutName];
        cell.detailTextLabel.text = selectedLayoutInfo;
        
        NSMutableAttributedString *tmp = [[NSMutableAttributedString alloc] initWithString:name];
        [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize] range:NSMakeRange(0, tmp.length)];
        cell.textLabel.attributedText = tmp;
    } else {
        cell.textLabel.text = name;
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *languageCode = [_languageCodes objectAtIndex:indexPath.row];
    NSString *key = [InputStickPreferencesHelper keyForItem:InputStickSettingsItemKeyboardLayout];
    
    InputStickKeyboardLayoutSelectionTableViewController *vc = nil;
    vc = [[InputStickKeyboardLayoutSelectionTableViewController alloc] initWithKey:key
                                                                      userDefaults:self.userDefaults
                                                                      languageCode:languageCode];
    
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
