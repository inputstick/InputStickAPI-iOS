/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoSelectKeyboardViewController.h"
#import "ISKeyboardLayoutEnUS.h"
#import "ISKeyboardLayoutDaDK.h"
#import "ISKeyboardLayoutDeCH.h"
#import "ISKeyboardLayoutDeDE.h"
#import "ISKeyboardLayoutDeDEMac.h"
#import "ISKeyboardLayoutEnDV.h"
#import "ISKeyboardLayoutEnGB.h"
#import "ISKeyboardLayoutEsES.h"
#import "ISKeyboardLayoutFiFI.h"
#import "ISKeyboardLayoutFrCH.h"
#import "ISKeyboardLayoutFrFR.h"
#import "ISKeyboardLayoutHeIL.h"
#import "ISKeyboardLayoutItIT.h"
#import "ISKeyboardLayoutNbNO.h"
#import "ISKeyboardLayoutPlPL.h"
#import "ISKeyboardLayoutPtBR.h"
#import "ISKeyboardLayoutRuRU.h"
#import "ISKeyboardLayoutSkSK.h"
#import "ISKeyboardLayoutSvSE.h"

@interface ISDemoSelectKeyboardViewController ()
@property(nonatomic, strong) NSArray *keyboardLayoutsArray;
@property(nonatomic, readwrite) id <ISKeyboardLayoutProtocol> selectedLayout;
@end

@implementation ISDemoSelectKeyboardViewController

#pragma mark - Object lifecycle

- (instancetype)initWithCurrentKeyboardLayout:(id <ISKeyboardLayoutProtocol>)layout {
    self = [super init];
    if (self) {
        self.keyboardLayoutsArray = [self keyboardLayouts];
        self.selectedLayout = layout;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keyboardLayoutsArray.count;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id <ISKeyboardLayoutProtocol> keyboardLayout = self.keyboardLayoutsArray[(NSUInteger) indexPath.row];
    cell.textLabel.text = keyboardLayout.layoutDescription;
    [cell setSelected:keyboardLayout == self.selectedLayout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id <ISKeyboardLayoutProtocol> layout = self.keyboardLayoutsArray[(NSUInteger) indexPath.row];
    [self.delegate selectKeyboardViewController:self
                         selectedKeyboardLayout:layout];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helpers

- (NSArray *)keyboardLayouts {
    return @[
            [[ISKeyboardLayoutDaDK alloc] init],
            [[ISKeyboardLayoutDeCH alloc] init],
            [[ISKeyboardLayoutDeDE alloc] init],
            [[ISKeyboardLayoutDeDEMac alloc] init],
            [[ISKeyboardLayoutEnDV alloc] init],
            [[ISKeyboardLayoutEnGB alloc] init],
            [[ISKeyboardLayoutEnUS alloc] init],
            [[ISKeyboardLayoutEsES alloc] init],
            [[ISKeyboardLayoutFiFI alloc] init],
            [[ISKeyboardLayoutFrCH alloc] init],
            [[ISKeyboardLayoutFrFR alloc] init],
            [[ISKeyboardLayoutHeIL alloc] init],
            [[ISKeyboardLayoutItIT alloc] init],
            [[ISKeyboardLayoutNbNO alloc] init],
            [[ISKeyboardLayoutPlPL alloc] init],
            [[ISKeyboardLayoutPtBR alloc] init],
            [[ISKeyboardLayoutRuRU alloc] init],
            [[ISKeyboardLayoutSkSK alloc] init],
            [[ISKeyboardLayoutSvSE alloc] init]
    ];
}

@end
