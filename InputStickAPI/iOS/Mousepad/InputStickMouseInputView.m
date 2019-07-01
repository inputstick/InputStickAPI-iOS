/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickMouseInputView.h"

static NSUInteger const BarHeight = 6;;


@interface InputStickMouseInputView () {
    UIPanGestureRecognizer *_moveGestureRecognizer;
    UIPanGestureRecognizer *_scrollGestureRecognizer;
    
    BOOL _wasMoved;
    BOOL _hide;
    BOOL _scrollMode;
    CGPoint _center;
    
    CGPoint _initialScrollLocation;
    CGPoint _lastScrollLocation;
    CGFloat _deadZoneUp, _deadZoneDown;
    CGFloat _scrollLockedUpHi, _scrollLockedUpLo, _scrollLockedDownHi, _scrollLockedDownLo;
}

@end


@implementation InputStickMouseInputView

#pragma mark - Object lifecycle

- (instancetype)initWithRatio:(float)ratio {
    self = [super init];
    if (self) {
        _ratio = ratio;
        self.clipsToBounds = YES;
        
        _interfaceColor = [UIColor whiteColor];
        _scrollPositionMarkerColor = [UIColor orangeColor];
        _scrollLockMarkerColor = [UIColor redColor];
        
        
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_infoLabel];
        _hide = TRUE;
        
        
        _moveGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
        _moveGestureRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:_moveGestureRecognizer];
        
        
        _scrollGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScroll:)];
        _scrollGestureRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:_scrollGestureRecognizer];
    }
    return self;
}


#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    [_infoLabel sizeToFit];
    _center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    _deadZoneUp = self.frame.size.height * 0.4f;
    _deadZoneDown = self.frame.size.height * 0.6f;
    _scrollLockedUpHi = 1.5f * BarHeight;
    _scrollLockedUpLo = 3.5f * BarHeight;
    _scrollLockedDownHi = self.frame.size.height - (1.5 * BarHeight);
    _scrollLockedDownLo = self.frame.size.height - (3.5 * BarHeight);
    _infoLabel.center = _center;
}

- (void)setFrame:(CGRect)frame {
    CGSize ratioAdjustedRect = [self rectSizeWithRatio:_ratio width:frame.size.width height:frame.size.height];
    NSUInteger tmpX = frame.origin.x + (frame.size.width - ratioAdjustedRect.width)/2;
    NSUInteger tmpY = frame.origin.y + (frame.size.height - ratioAdjustedRect.height);
    
    //3% radius
    if (ratioAdjustedRect.width > ratioAdjustedRect.height) {
        self.layer.cornerRadius = ratioAdjustedRect.height / 33;
    } else {
        self.layer.cornerRadius = ratioAdjustedRect.width / 33;
    }
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [super setFrame:CGRectMake(tmpX, tmpY, ratioAdjustedRect.width, ratioAdjustedRect.height)];
}

- (void)drawRect:(CGRect)rect {
    if (_scrollMode) {
        UIBezierPath *bezierPath;
        CGFloat x,y,w;
        CGFloat viewWidth = self.frame.size.width;
        CGFloat viewHeight = self.frame.size.height;
        NSUInteger n = (_deadZoneUp - (4 * BarHeight)) / (2 * BarHeight);
        
        //max HI:
        x = viewWidth /3;
        w = viewWidth / 3;
        y = BarHeight;
        [_scrollLockMarkerColor setFill];
        [self updateFillColorForY:y];
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
        [bezierPath fill];
        //min HI:
        y = viewHeight - (2 * BarHeight);
        [_scrollLockMarkerColor setFill];
        [self updateFillColorForY:y];
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
        [bezierPath fill];
        //max LO:
        x = viewWidth * 3 / 8;
        w = viewWidth / 4;
        y = 3 * BarHeight;
        [_scrollLockMarkerColor setFill];
        [self updateFillColorForY:y];
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
        [bezierPath fill];
        //min LO:
        y = viewHeight - (4 * BarHeight);
        [_scrollLockMarkerColor setFill];
        [self updateFillColorForY:y];
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
        [bezierPath fill];
        
        //up:
        x = viewWidth * 7 / 16;
        w = viewWidth / 8;
        y = 3 * BarHeight;
        [_interfaceColor setFill];
        for (int i = 0; i < n; i++) {
            y += 2 * BarHeight;
            [self updateFillColorForY:y];
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
            [bezierPath fill];
        }
        //down:
        y = viewHeight - 4 * BarHeight;
        [_interfaceColor setFill];
        for (int i = 0; i < n; i++) {
            y -= 2 * BarHeight;
            [self updateFillColorForY:y];
            bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, BarHeight)];
            [bezierPath fill];
        }
        
        //position marker:
        [_scrollPositionMarkerColor setFill];
        
        w = viewWidth;
        x = 0;
        y = _lastScrollLocation.y;
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y - (BarHeight / 2), w, BarHeight)];
        [bezierPath fill];
    }
}

- (void)updateFillColorForY:(CGFloat)y {
    if (y < self.frame.size.height / 2) {
        if (_lastScrollLocation.y < (y + (BarHeight / 2))) {
            [_scrollPositionMarkerColor setFill];
        }
    } else {
        if (_lastScrollLocation.y > (y + (BarHeight / 2))) {
            [_scrollPositionMarkerColor setFill];
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_infoLabel];
    [self.delegate inputSticMouseInputView:self didReceiveTouchAtPoint:location];
    [self.delegate inputSticMouseInputView:self didReceiveTouchChange:TRUE];
    [self hideLabel];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Triggered when touch is released
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_infoLabel];
    [self.delegate inputSticMouseInputView:self didReceiveTouchAtPoint:location];
    [self.delegate inputSticMouseInputView:self didReceiveTouchChange:FALSE];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Triggered when touch leaves view
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_infoLabel];
    [self.delegate inputSticMouseInputView:self didReceiveTouchAtPoint:location];
    
    if ( !_wasMoved) {
        [self.delegate inputSticMouseInputView:self didReceiveTouchChange:FALSE];
    }
}


#pragma mark - Handle touch

- (void)handleMove:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    [self.delegate inputSticMouseInputView:self didReceiveMoveAtPoint:location];
    
    _wasMoved = TRUE;
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _wasMoved = FALSE;
        [self.delegate inputSticMouseInputView:self didReceiveTouchChange:FALSE];
    }
}

- (void)handleScroll:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    BOOL redraw = FALSE;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _initialScrollLocation = location;
        _lastScrollLocation = _initialScrollLocation;
        [self.delegate inputSticMouseInputView:self didEnterMode:InputStickMouseInputViewModeScrollWheel];
        _scrollMode = TRUE;
        redraw = TRUE;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.delegate inputSticMouseInputView:self didEnterMode:InputStickMouseInputViewModeMousePad];
        _scrollMode = FALSE;
        redraw = TRUE;
    }
    
    CGFloat diff = _lastScrollLocation.y - location.y;
    _lastScrollLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if ((diff >= 0.5) || (diff <= -0.5)) {
        redraw = TRUE;
    }
    if (redraw) {
        [self setNeedsDisplay];
    }
    
    CGFloat scrollValue = 0.0f;
    InputStickMouseInputViewScrollWheelMode mode = InputStickMouseInputViewScrollWheelModeIdle;
    
    if (_lastScrollLocation.y < _deadZoneUp) {
        scrollValue = _deadZoneUp - _lastScrollLocation.y;
        mode = InputStickMouseInputViewScrollWheelModeScroll;
        if (_lastScrollLocation.y < _scrollLockedUpLo) {
            mode = InputStickMouseInputViewScrollWheelModeLockedLo;
        }
        if (_lastScrollLocation.y < _scrollLockedUpHi) {
            mode = InputStickMouseInputViewScrollWheelModeLockedHi;
        }
    }
    if (_lastScrollLocation.y > _deadZoneDown) {
        scrollValue = _deadZoneDown - _lastScrollLocation.y;
        mode = InputStickMouseInputViewScrollWheelModeScroll;
        if (_lastScrollLocation.y > _scrollLockedDownLo) {
            mode = InputStickMouseInputViewScrollWheelModeLockedLo;
        }
        if (_lastScrollLocation.y > _scrollLockedDownHi) {
            mode = InputStickMouseInputViewScrollWheelModeLockedHi;
        }
    }
    [self.delegate inputSticMouseInputView:self didReceiveScrollValue:scrollValue withMode:mode];
}


#pragma mark - Property

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    [_scrollGestureRecognizer setEnabled:scrollEnabled]; 
}



#pragma mark - Helpers

- (void)hideLabel {
    if (_hide) {
        _hide = FALSE;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 1;
        [_infoLabel.layer addAnimation:animation forKey:nil];
        _infoLabel.hidden = YES;
    }
}

- (CGSize)rectSizeWithRatio:(float)ratio width:(NSUInteger)width height:(NSUInteger)height {
    float f;
    if (ratio == 0) {
        return CGSizeMake(width, height);
    } else {
        f = (float)width / ratio;
        if (f <height) {
            return CGSizeMake(width, f);
        } else {
            f = (float)height * ratio;
            return CGSizeMake(f, height);
        }
    }
}

@end
