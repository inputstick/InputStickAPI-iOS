/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "ISDeviceSelectionTableViewCell.h"

NSString *const InputStickDeviceName = @"InputStick";

@interface ISDeviceSelectionTableViewCell ()
@property(nonatomic, strong) NSMutableArray *registeredContraints;
@end

@implementation ISDeviceSelectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.registeredContraints = [NSMutableArray array];

        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        self.identifierLabel = [[UILabel alloc] init];
        self.identifierLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.identifierLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.identifierLabel];

        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self removeConstraints:self.registeredContraints];
    [self.registeredContraints removeAllObjects];

    NSDictionary *views = @{
            @"textLabel" : self.textLabel,
            @"identifierLabel" : self.identifierLabel};

    [self.registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textLabel]-|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];
    [self.registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[identifierLabel]-|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];

    [self.registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textLabel][identifierLabel]|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];

    [self addConstraints:self.registeredContraints];
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)configureWithPeripheral:(CBPeripheral *)peripheral {
    NSString *peripheralNameString = [NSString stringWithFormat:@"Name:  %@", peripheral.name];
    BOOL isInputStickDevice = [peripheral.name isEqualToString:InputStickDeviceName];
    if (isInputStickDevice) {
        NSMutableAttributedString *nameAttributedString = [[NSMutableAttributedString alloc] initWithString:peripheralNameString];
        [nameAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16]
                                     range:NSMakeRange(0, 7)];
        [nameAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16]
                                     range:NSMakeRange(7, peripheralNameString.length - 7)];
        self.textLabel.attributedText = nameAttributedString;
    } else {
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.text = peripheralNameString;
    }

    self.identifierLabel.text = [peripheral.identifier UUIDString];
    [self setNeedsUpdateConstraints];
}

@end
