/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickDemoUtils.h"

@implementation InputStickDemoUtils

+ (UIButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newButton.tag = tag;
    newButton.layer.borderWidth = 2;
    newButton.layer.borderColor = [UIColor whiteColor].CGColor;
    newButton.layer.cornerRadius = 5;    
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor colorWithRed:62.f / 255.f green:146.f / 255.f blue:241.f / 255.f alpha:1]];
    return newButton;
}

@end
