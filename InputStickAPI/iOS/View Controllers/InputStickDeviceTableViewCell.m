/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "InputStickDeviceTableViewCell.h"
#import "InputStickTheme.h"
#import "InputStickConnectionManager.h"
#import "InputStickPeripheralInfo.h"
#import "InputStickDeviceData.h"
#import "InputStickConst.h"


@interface InputStickDeviceTableViewCell () {
    NSMutableArray *_registeredContraints;
}

@end


@implementation InputStickDeviceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _registeredContraints = [NSMutableArray array];
        
        //!!! DO NOT USE >3 UILabels
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.nameLabel];
        
        self.identifierLabel = [[UILabel alloc] init];
        self.identifierLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.identifierLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.identifierLabel];
        
        self.actionLabel = [[UILabel alloc] init];
        self.actionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.actionLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.actionLabel];
        
        [self setNeedsUpdateConstraints];
        
        self.actionLabel.textColor = [UIColor redColor];
        
        [InputStickTheme themeInputStickDeviceTableViewCell:self];
    }
    return self;
}

- (void)updateConstraints {
    [self removeConstraints:_registeredContraints];
    [_registeredContraints removeAllObjects];
    
    NSDictionary *views = @{@"nameLabel" : self.nameLabel,
                            @"identifierLabel" : self.identifierLabel,
                            @"actionLabel" : self.actionLabel};
    
    [_registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel]-|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];
    [_registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[identifierLabel]-|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];
    [_registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[actionLabel]-|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];
    
    [_registeredContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nameLabel][identifierLabel][actionLabel]|"
                                                                                           options:(NSLayoutFormatOptions) 0
                                                                                           metrics:nil
                                                                                             views:views]];
    
    [self addConstraints:_registeredContraints];
    [super updateConstraints];
}

- (UILabel *)textLabel {
    return self.nameLabel;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)configureWithInputStickPeripheralInfo:(InputStickPeripheralInfo *)peripheralInfo withDatabaseName:(NSString *)dbName {
    NSString *peripheralNameString;
    NSString *nameText = NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_NAME", InputStickStringTable, nil);
    NSUInteger nameTextLength = [nameText length] + 2; // "Name" + ": "
    if (peripheralInfo.peripheral.name != nil) {
        peripheralNameString = [NSString stringWithFormat:@"%@: %@", nameText, peripheralInfo.peripheral.name];
    } else {
        peripheralNameString = [NSString stringWithFormat:@"%@: %@", nameText, NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_UNKNOWN", InputStickStringTable, nil)];
    }
    
    BOOL isInputStickDevice = [peripheralInfo.peripheral.name isEqualToString:InputStickBluetoothDefaultName];
    if (isInputStickDevice) {        
        //mark the devices name with blue color, it is almost 100% InputStick
        NSMutableAttributedString *nameAttributedString = [[NSMutableAttributedString alloc] initWithString:peripheralNameString]; //"InputStick"
        [nameAttributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:16]
                                     range:NSMakeRange(0, nameTextLength)];
        [nameAttributedString addAttribute:NSFontAttributeName
                                     value:[UIFont boldSystemFontOfSize:16]
                                     range:NSMakeRange(nameTextLength, peripheralNameString.length - nameTextLength)];
        [nameAttributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                                     range:NSMakeRange(nameTextLength, peripheralNameString.length - nameTextLength)];
        
        if (dbName != nil) {
            NSMutableAttributedString *dbNameAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" (%@)", dbName]];
            [nameAttributedString appendAttributedString:dbNameAttributedString];
        }
        
        self.nameLabel.attributedText = nameAttributedString;
    } else {
        //this can be a different BT device with same BT services or InputStick with modified SSID
        if (dbName != nil) {
            peripheralNameString = [peripheralNameString stringByAppendingString:[NSString stringWithFormat:@" (%@)", dbName]];
        }
        
        self.nameLabel.text = peripheralNameString;
    }
    self.identifierLabel.text = [NSString stringWithFormat:@"(%@: %@)", NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_BT_ID", InputStickStringTable, nil), peripheralInfo.identifier];
    
    [self setNeedsUpdateConstraints];
}

- (void)configureWithInputStickDeviceData:(InputStickDeviceData *)deviceData withMostRecentlyUsedIdentifier:(NSString *)recentIdentifier {
    self.nameLabel.text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_NAME", InputStickStringTable, nil), deviceData.name];
    if ([deviceData.identifier isEqualToString:recentIdentifier]) {
        self.identifierLabel.text = [NSString stringWithFormat:@"(%@)", NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_MOST_RECENT_DEVICE", InputStickStringTable, nil)];
    }
    NSString *tmp = @"";
    if ( ![deviceData hasLatestFirmware]) {
        tmp = [tmp stringByAppendingString:NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_FW_UPDATE", InputStickStringTable, nil)];
    }
    if ([deviceData hasPasswordProtectionIssue]) {
        if ([tmp length] > 0) {
            tmp = [tmp stringByAppendingString:@" "];
        }
        tmp = [tmp stringByAppendingString:NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_CHECK_SECURITY", InputStickStringTable, nil)];
    }
    
    if ([tmp length] > 0) {
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@" %@", NSLocalizedStringFromTable(@"INPUTSTICK_CELL_TEXT_MORE_INFO", InputStickStringTable, nil)]];
    }
    self.actionLabel.text = tmp;
    
    [self setNeedsUpdateConstraints];
}


@end
