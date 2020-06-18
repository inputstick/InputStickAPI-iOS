/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import "InputStickKeyboardLanguageSelectionTableViewController.h"
#import "InputStickKeyboardLayoutSelectionTableViewController.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickKeyboardLayoutUtils.h"
#import "InputStickPreferences.h"
#import "InputStickPreferencesHelper.h"
#import "InputStickConst.h"
#import "InputStickTheme.h"

static NSString *const CellReuseIdentifier = @"InputStickSettingsKeyboardLanguageSelectionCellIdentifier";


@interface InputStickKeyboardLanguageSelectionTableViewController () {
    NSString *_selectedLayoutCode;
    NSString *_selectedLayoutName;
    NSInteger _checkedIndex;
    NSArray<NSString *> *_languageNames;
    NSArray<NSString *> *_languageCodes;
}

@end


@implementation InputStickKeyboardLanguageSelectionTableViewController

#pragma mark - Object lifecycle

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults key:(NSString *)key {
    self = [super init];
    if (self) {
        self.userDefaults = userDefaults;
        self.key = key;
        
        _languageNames = [InputStickKeyboardLayoutUtils keyboardLayoutLanguageNames];
        _languageCodes = [InputStickKeyboardLayoutUtils keyboardLayoutLanguageCodes];
        _selectedLayoutCode = [_userDefaults objectForKey:self.key];
        //failsafe:
        NSArray<NSString *> *layoutCodes = [InputStickKeyboardLayoutUtils keyboardLayoutCodes];
        if ( ![layoutCodes containsObject:_selectedLayoutCode]) {
            _selectedLayoutCode = @"en-US";
        }

        id <InputStickKeyboardLayoutProtocol> keyboardLayout = [InputStickKeyboardLayoutUtils keyboardLayoutWithCode:_selectedLayoutCode];
        
        NSString *selectedLanguageCode = [keyboardLayout layoutLanguageCode];
        _checkedIndex = -1;
        if ([_languageCodes containsObject: selectedLanguageCode]) {
            _checkedIndex = [_languageCodes indexOfObject:selectedLanguageCode];
            _selectedLayoutName = [keyboardLayout layoutDisplayName];
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
    //do not registerClass forCellReuseIdentifier! we need UITableViewCellStyleSubtitle! see cellForRowAtIndexPath
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
        [InputStickTheme themeTableViewCell:cell];        
    }
    
    NSUInteger index = indexPath.row;
    NSString *name = [_languageNames objectAtIndex:index];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSMutableAttributedString *tmp = [[NSMutableAttributedString alloc] initWithString:name];
    if (index == _checkedIndex) {
        NSString *selectedLayoutInfo = NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TEXT_SELECTED_LAYOUT", InputStickStringTable, nil);
        selectedLayoutInfo = [selectedLayoutInfo stringByAppendingString:_selectedLayoutName];
        cell.detailTextLabel.text = selectedLayoutInfo;
                
        [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize + 4] range:NSMakeRange(0, tmp.length)];
        cell.textLabel.attributedText = tmp;
    } else {
        cell.detailTextLabel.text = nil;
        cell.textLabel.attributedText = tmp;
    }
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *languageCode = [_languageCodes objectAtIndex:indexPath.row];
    
    InputStickKeyboardLayoutSelectionTableViewController *vc = nil;
    vc = [[InputStickKeyboardLayoutSelectionTableViewController alloc] initWithUserDefaults:self.userDefaults
                                                                                        key:self.key
                                                                               languageCode:languageCode
                                                                                 layoutCode:_selectedLayoutCode];
    
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
