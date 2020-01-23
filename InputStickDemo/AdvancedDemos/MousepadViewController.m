/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "MousepadViewController.h"
#import "MainTableViewController.h"
#import "InputStickDemoUtils.h"

#import "InputStickMouseHandler.h"
#import "InputStickTouchScreenHandler.h"
#import "InputStickPreferences.h"

#import "InputStickBarButtonItem.h"
#import "InputStickMouseInputView.h"
#import "InputStickMouseSupport.h"


static NSUInteger const ContentMargin = 16;
static NSUInteger const ContentPadding = 8;


@interface MousepadViewController () {
    InputStickMouseInputView *_mouseInputView;
    UIButton *_buttonMouseLeft;
    UIButton *_buttonMouseMiddle;
    UIButton *_buttonMouseRight;
    
    InputStickMouseSupport *_mouseSupport;
}

@end


@implementation MousepadViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mousepad";
    
    _mouseSupport = [[InputStickMouseSupport alloc] init];
    _mouseSupport.inputStickManager = self.inputStickManager;
    _mouseSupport.preferences = _preferences;
    _mouseInputView.delegate = _mouseSupport;
    //or:
    //_mouseInputView.delegate = self;
    //if you want to handle mouse actions yourself / see InputStickMouseInputViewDelegate methods
    
    //add InputStickBarButtonItem to allow to connect/disconnect with a single click
    InputStickBarButtonItem *barButtonItem = [[InputStickBarButtonItem alloc] initWithInputStickManager:self.inputStickManager];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //disable swipe back gesture, to avoid accidentally trigering it when using mousepad area:
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mouseSupport cleanUp];
    //re-enable swipe back gesture:
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [super viewWillDisappear:animated];
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    if (@available(iOS 13, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    _mouseInputView = [[InputStickMouseInputView alloc] initWithRatio:_preferences.mousepadRatio];
    //customize:
    _mouseInputView.backgroundColor = [UIColor colorWithRed:105.f / 255.f green:170.f / 255.f blue:244.f / 255.f alpha:1];
    //_mouseInputView.scrollPositionMarkerColor = [UIColor greenColor];
    //_mouseInputView.scrollLockMarkerColor = [UIColor yellowColor];
    
    //disable scrolling?
    //_mouseInputView.scrollEnabled = NO;
    
    //setup info label
    _mouseInputView.infoLabel.attributedText = [self attributedTextForInfoLabelWithMode:_preferences.touchScreenMode tapToClick:_preferences.tapToClick];
     if (_preferences.tapToClick) {
         _mouseInputView.infoLabel.numberOfLines = 5;
     } else {
        _mouseInputView.infoLabel.numberOfLines = 4;
     }
    
    //setup buttons
    _buttonMouseLeft = [InputStickDemoUtils buttonWithTitle:@"Left" tag:MouseButtonLeft];
    [_buttonMouseLeft addTarget:self action:@selector(buttonMousePress:)
               forControlEvents:UIControlEventTouchDown];
    [_buttonMouseLeft addTarget:self action:@selector(buttonMouseRelease:)
               forControlEvents:UIControlEventTouchUpInside];
    [_buttonMouseLeft addTarget:self action:@selector(buttonMouseRelease:)
               forControlEvents:UIControlEventTouchUpOutside];
    [_buttonMouseLeft addTarget:self action:@selector(buttonMouseRelease:)
               forControlEvents:UIControlEventTouchCancel];
    [_buttonMouseLeft addTarget:self action:@selector(buttonMouseRelease:)
               forControlEvents:UIControlEventTouchDragExit];
    
    _buttonMouseMiddle = [InputStickDemoUtils buttonWithTitle:@"Mid" tag:MouseButtonMiddle];
    [_buttonMouseMiddle addTarget:self action:@selector(buttonMousePress:)
                 forControlEvents:UIControlEventTouchDown];
    [_buttonMouseMiddle addTarget:self action:@selector(buttonMouseRelease:)
                 forControlEvents:UIControlEventTouchUpInside];
    [_buttonMouseMiddle addTarget:self action:@selector(buttonMouseRelease:)
                 forControlEvents:UIControlEventTouchUpOutside];
    [_buttonMouseMiddle addTarget:self action:@selector(buttonMouseRelease:)
                 forControlEvents:UIControlEventTouchCancel];
    [_buttonMouseMiddle addTarget:self action:@selector(buttonMouseRelease:)
                 forControlEvents:UIControlEventTouchDragExit];
    
    _buttonMouseRight = [InputStickDemoUtils buttonWithTitle:@"Right" tag:MouseButtonRight];
    [_buttonMouseRight addTarget:self action:@selector(buttonMousePress:)
                forControlEvents:UIControlEventTouchDown];
    [_buttonMouseRight addTarget:self action:@selector(buttonMouseRelease:)
                forControlEvents:UIControlEventTouchUpInside];
    [_buttonMouseRight addTarget:self action:@selector(buttonMouseRelease:)
                forControlEvents:UIControlEventTouchUpOutside];
    [_buttonMouseRight addTarget:self action:@selector(buttonMouseRelease:)
                forControlEvents:UIControlEventTouchCancel];
    [_buttonMouseRight addTarget:self action:@selector(buttonMouseRelease:)
                forControlEvents:UIControlEventTouchDragExit];
    
    [self.view addSubview:_mouseInputView];
    [self.view addSubview:_buttonMouseLeft];
    [self.view addSubview:_buttonMouseMiddle];
    [self.view addSubview:_buttonMouseRight];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat tabBarHeight = 0;
    CGFloat statusBarHeight =  [UIApplication sharedApplication].statusBarFrame.size.height; // 20 / 0
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height; // 44 / 32
    
    CGFloat barsHeight = tabBarHeight + statusBarHeight + navigationBarHeight;
    
    CGRect buttonFrame;
    CGFloat buttonWidth, buttonHeight;
    
    CGFloat frameWidth = CGRectGetWidth(self.view.frame);
    CGFloat frameHeight = CGRectGetHeight(self.view.frame);
    CGFloat contentWidth = frameWidth - 2 * ContentMargin;
    CGFloat contentHeight = frameHeight - 2 * ContentMargin - barsHeight;
    CGFloat bottom = frameHeight - tabBarHeight - ContentMargin;
    CGFloat top = statusBarHeight + navigationBarHeight + ContentMargin;
    CGFloat left = ContentMargin;
    CGFloat right = frameWidth - ContentMargin;
    
    
    CGFloat maxPadWidth, maxPadHeight;
    if (contentHeight >= contentWidth) {
        buttonHeight = contentHeight / 7; //14% of total height
        
        maxPadWidth = contentWidth;
        maxPadHeight = contentHeight - buttonHeight - ContentPadding;
        [_mouseInputView setFrame:CGRectMake(left, (bottom - buttonHeight - ContentPadding - maxPadHeight), maxPadWidth, maxPadHeight)];
        
        buttonWidth = (contentWidth - 2 * ContentPadding) / 3;
        buttonFrame = CGRectMake(left, bottom - buttonHeight, buttonWidth, buttonHeight);
        [_buttonMouseLeft setFrame:buttonFrame];
        buttonFrame = CGRectMake(left + buttonWidth + ContentPadding, bottom - buttonHeight, buttonWidth, buttonHeight);
        [_buttonMouseMiddle setFrame:buttonFrame];
        buttonFrame = CGRectMake(left + buttonWidth + ContentPadding + buttonWidth + ContentPadding, bottom - buttonHeight, buttonWidth, buttonHeight);
        [_buttonMouseRight setFrame:buttonFrame];
    } else {
        buttonWidth = contentWidth / 7; //14% of total width
        
        maxPadWidth = contentWidth - (2 * buttonWidth) - (2 * ContentPadding);
        maxPadHeight = contentHeight;
        [_mouseInputView setFrame:CGRectMake((left + buttonWidth + ContentPadding), top, maxPadWidth, maxPadHeight)];
        
        buttonHeight = contentHeight;
        buttonFrame = CGRectMake(left, top, buttonWidth, buttonHeight);
        [_buttonMouseLeft setFrame:buttonFrame];
        
        buttonHeight = (contentHeight - ContentPadding) / 2;
        buttonFrame = CGRectMake(right - buttonWidth, top, buttonWidth, buttonHeight);
        [_buttonMouseMiddle setFrame:buttonFrame];
        buttonFrame = CGRectMake(right - buttonWidth, top + buttonHeight + ContentPadding, buttonWidth, buttonHeight);
        [_buttonMouseRight setFrame:buttonFrame];
    }
    
    [_mouseSupport setupWithInputView:_mouseInputView];
}


#pragma mark - Mouse Buttons Action

- (IBAction) buttonMouseRelease:(id)sender {
    UIButton *clicked = (UIButton *)sender;
    [_mouseSupport mouseButtonEventWithPressedState:FALSE withButton:clicked.tag];
}

- (IBAction) buttonMousePress:(id)sender {
    UIButton *clicked = (UIButton *)sender;
    [_mouseSupport mouseButtonEventWithPressedState:TRUE withButton:clicked.tag];
}

//if you want to handler mouse actions yourself / provide additional features, like click-feedback
//set: _mouseInputView.delegate = self;  in viewDidLoad
#pragma mark - InputStickMouseInputViewDelegate

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveMoveAtPoint:(CGPoint)movePoint {
    [_mouseSupport inputSticMouseInputView:view didReceiveMoveAtPoint:movePoint];
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveScrollValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode {
    [_mouseSupport inputSticMouseInputView:view didReceiveScrollValue:scrollValue withMode:mode];
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchChange:(BOOL)touched {
    if (touched) {
        BOOL prev = _mouseSupport.mousepadClicked;
        [_mouseSupport inputSticMouseInputView:view didReceiveTouchChange:touched];
        
        if ( !prev && _mouseSupport.mousepadClicked) {
            //click feedback, sound? vibrations?
        }
    } else {
        [_mouseSupport inputSticMouseInputView:view didReceiveTouchChange:touched];
    }
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchAtPoint:(CGPoint)touchPoint {
    [_mouseSupport inputSticMouseInputView:view didReceiveTouchAtPoint:touchPoint];
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didEnterMode:(InputStickMouseInputViewMode)mode {
    [_mouseSupport inputSticMouseInputView:view didEnterMode:mode];
}


#pragma mark - Helpers

- (NSMutableAttributedString *)attributedTextForInfoLabelWithMode:(BOOL)mode tapToClick:(BOOL)tapToClick {
    NSMutableAttributedString *descString, *tmp;
    
    if (mode) {
        descString = [[NSMutableAttributedString alloc] initWithString:@"Touch-screen mode\n"];
        [descString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, descString.length)];
        [descString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, 12)];
    } else {
        descString = [[NSMutableAttributedString alloc] initWithString:@"Mouse mode\n"];
        [descString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, descString.length)];
        [descString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, 5)];
    }
    
    tmp = [[NSMutableAttributedString alloc] initWithString:@"Move with one finger\nScroll with two fingers"];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, tmp.length)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, 4)];
    [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(21, 6)];
    [descString appendAttributedString:tmp];
    
    if (tapToClick) {
        tmp = [[NSMutableAttributedString alloc] initWithString:@"\nTap 2x to click"];
        [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, tmp.length)];
        [tmp addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(1, 6)];
        [descString appendAttributedString:tmp];
    }
    
    tmp = [[NSMutableAttributedString alloc] initWithString:@"\n(open app settings to adjust)"];
    [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, tmp.length)];
    [descString appendAttributedString:tmp];
    
    return descString;
}

@end
