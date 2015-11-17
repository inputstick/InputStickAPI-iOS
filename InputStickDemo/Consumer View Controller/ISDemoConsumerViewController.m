/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoConsumerViewController.h"
#import "ISConsumerHandler.h"
#import "ISDemoConsumerCellDefinition.h"


@interface ISDemoConsumerViewController ()
@property(nonatomic, strong) NSArray *sectionDefinitionArray;
@end

@implementation ISDemoConsumerViewController

#pragma mark - object lifecycle

- (instancetype)initWithConsumerHandler:(ISConsumerHandler *)consumerHandler {
    self = [super init];
    if (self) {
        _consumerHandler = consumerHandler;

        NSArray *firstSectionItems = @[
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionVolumeUp
                                                                       title:@"Up"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionVolumeDown
                                                                       title:@"Down"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionVolumeMute
                                                                       title:@"Mute"]
        ];

        NSArray *secondSecitonItems = @[
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionTrackNext
                                                                       title:@"Next"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionTrackPrevious
                                                                       title:@"Previous"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionStop
                                                                       title:@"Stop"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionPlayPause
                                                                       title:@"Play/Pause"]
        ];

        NSArray *thidSectionItems = @[
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionLaunchBrowser
                                                                       title:@"Browser"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionLaunchCalc
                                                                       title:@"Calculator"],
                [[ISDemoConsumerCellDefinition alloc] initWithConsumerAction:ConsumerActionLaunchEmail
                                                                       title:@"E-mail"]
        ];

        NSArray *forthSectionItems = @[
                [[ISDemoConsumerCellDefinition alloc] initWithSystemAction:SystemActionPowerDown
                                                                     title:@"Power down"],
                [[ISDemoConsumerCellDefinition alloc] initWithSystemAction:SystemActionSleep
                                                                     title:@"Sleep"],
                [[ISDemoConsumerCellDefinition alloc] initWithSystemAction:SystemActionWakeup
                                                                     title:@"Wake up"]
        ];

        self.sectionDefinitionArray = @[
                firstSectionItems,
                secondSecitonItems,
                thidSectionItems,
                forthSectionItems
        ];
    }
    return self;
}

#pragma mark - UIView

- (void)viewDidLoad {
    self.title = @"Consumer HID";
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];

    [super viewDidLoad];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDefinitionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.sectionDefinitionArray[(NSUInteger) section];
    return sectionItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerTitle;
    switch (section) {
        case 0:
            headerTitle = @"Volume";
            break;
        case 1:
            headerTitle = @"Track";
            break;
        case 2:
            headerTitle = @"Launch";
            break;
        case 3:
            headerTitle = @"System actions";
            break;
        default:
            return @"";
    }
    return headerTitle;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ISDemoConsumerCellDefinition *cellDefinition = [self cellDefinitionForIndexPath:indexPath];
    cell.textLabel.text = cellDefinition.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISDemoConsumerCellDefinition *cellDefinition = [self cellDefinitionForIndexPath:indexPath];
    BOOL hasConsumerAction = cellDefinition.consumerAction != 0;
    BOOL hasSystemAction = cellDefinition.systemAction != 0;

    if (hasConsumerAction) {
        [self.consumerHandler consumerActionWithUsage:cellDefinition.consumerAction];
    }
    if (hasSystemAction) {
        [self.consumerHandler systemActionWithUsage:cellDefinition.systemAction];
    }
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - Helpers

- (ISDemoConsumerCellDefinition *)cellDefinitionForIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.sectionDefinitionArray[(NSUInteger) indexPath.section];
    ISDemoConsumerCellDefinition *cellDefinition = sectionItems[(NSUInteger) indexPath.row];
    return cellDefinition;
}


@end
