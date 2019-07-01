/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickMouseSupport.h"
#import "InputStickManager.h"
#import "InputStickMouseHandler.h"
#import "InputStickTouchScreenHandler.h"
#import "InputStickHIDTransaction.h"
#import "InputStickHIDBuffersManager.h"
#import "InputStickPreferences.h"


//values in ms
static NSUInteger const OutOfRangeTimeout = 5000; //inactivity time after which finger is considered off the screen in touch-screen mode
static NSUInteger const MouseRefreshInterval = 20; //min time interval between consecutive mousepad (screen) position updates, more frequent actions will be ignored
static NSUInteger const IdleResetInterval = 100; //time after which to reset lastX, lastY to current touch position
static NSUInteger const TapMinInterval = 20; //min time interval between consecutive mousepad (screen) taps, more frequent actions will be ignored
static NSUInteger const DeadZoneTimeoutPeriod = 500;
static NSUInteger const MinProximity = 225; //15px (squared) min distance between two touch events to still count as parts of the same action (2x tap to click etc.)
static float const MousepadRescaleFactor = 1.2f;

static NSUInteger const ScrollRefreshInterval = 20; //min time interval between consecutive scroll wheel position updates, more frequent actions will be ignored
static NSUInteger const ScrollAutoRotationInterval = 100; //time interval between scroll wheel updates when scroll wheel is locked in auto rotation up/down mode
static NSUInteger const ScrollAutoRotationDelay = 500; //delay until scroll wheel is locked in auto-rotation mode
static NSUInteger const ScrollMaxClicks = 16; //max scroll wheel "clicks" per single update

@interface InputStickMouseSupport () {
    NSUInteger _lastX, _lastY; //last x,y position of mousepad touch event
    NSTimeInterval _lastMoveTime; //when last mousepad touch event was processed
    NSTimeInterval _lastHIDUpdateTime; //when last HID report was sent
    
    NSTimeInterval _lastTapTime;
    NSUInteger _lastTapX, _lastTapY;
    BOOL _mouseInterfaceButtonsPressed;
    
    BOOL _tapState;

    BOOL _deadZone;
    NSUInteger _deadZoneX, _deadZoneY;
    NSTimeInterval _deadZoneTimeout;
    NSTimer *_outOfRangeTimer;
    
    NSInteger _scrollLastValue;
    NSInteger _scrollClicks;
    SignedByte _scrollDirection;
    NSInteger _scrollAutoRotationMode;
    NSUInteger _scrollAutoRotationCounter;
    NSTimer *_scrollTimer;
    
    NSInteger _touchScreenX, _touchScreenY;
    
    //iOS specific
    NSUInteger _padWidth, _padHeight;
    NSUInteger _proximityThreshold;
    //delegate:
    NSUInteger _mousepadX, _mousepadY;
}

@end


@implementation InputStickMouseSupport

#pragma mark - Setup

- (void)setupWithInputView:(UIView *)inputView {
    _padWidth = inputView.frame.size.width;
    _padHeight = inputView.frame.size.height;
    
    NSUInteger tmp = self.preferences.touchProximity;
    if (tmp == 0) {
        NSInteger h = _padHeight;
        NSInteger w = _padWidth;
        
        tmp = ((h * h) + (w * w)) / 1000; //3,3% tolarance
        if (tmp < MinProximity) {
            tmp = MinProximity;
        }
    }
    _proximityThreshold = tmp;
}

- (void)cleanUp {
    [self.inputStickManager.mouseHandler sendCustomReportWithButtons:0 x:0 y:0 scroll:0 flush:YES];
    if (_outOfRangeTimer != nil) {
        [self cancelOutOfRangeTimer];
        [self outOfRangeEvent];
    }
    
    _mouseInterfaceButtonsPressed = FALSE;
    _mousepadClicked = FALSE;
    _buttonStateLeft = FALSE;
    _buttonStateMiddle = FALSE;
    _buttonStateRight = FALSE;
    _tapState = FALSE;
    
    _scrollLastValue = 0;
    _scrollAutoRotationMode = 0;
    _scrollClicks = 0;
    _scrollAutoRotationCounter = 0;
    [self stopScrollTimer];
}


#pragma mark - InputStickMouseInputViewDelegate

- (void)inputSticMouseInputView:(InputStickMouseInputView *)inputView didReceiveMoveAtPoint:(CGPoint)movePoint {
    _mousepadX = movePoint.x;
    _mousepadY = movePoint.y;
    
    [self mousePadEvent:InputStickMousePadEventMove atX:_mousepadX Y:_mousepadY];
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveScrollValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode {
    [self scrollWheelEventWithValue:scrollValue withMode:mode];
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchAtPoint:(CGPoint)touchPoint {
    _mousepadX = touchPoint.x;
    _mousepadY = touchPoint.y;
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchChange:(BOOL)touched {
    if (touched) {
        [self mousePadEvent:InputStickMousePadEventDown atX:_mousepadX Y:_mousepadY];
    } else {
        [self mousePadEvent:InputStickMousePadEventUp atX:_mousepadX Y:_mousepadY];
    }
}

- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didEnterMode:(InputStickMouseInputViewMode)mode {
    [self mousePadModeChanged:mode];
}


#pragma mark - Mousepad area

- (void)mousePadModeChanged:(InputStickMouseInputViewMode)mode {
    _scrollLastValue = 0;
    _scrollAutoRotationMode = 0;
    _scrollClicks = 0;
    _scrollAutoRotationCounter = 0;
    if (mode == InputStickMouseInputViewModeScrollWheel) {
        [self startScrollTimer];
    }
    if (mode == InputStickMouseInputViewModeMousePad) {
        [self stopScrollTimer];
    }
}

- (void)mousePadEvent:(InputStickMousePadEvent)event atX:(NSUInteger)x Y:(NSUInteger)y {
    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970] * 1000);
    NSInteger toMoveX = 0;
    NSInteger toMoveY = 0;
    BOOL update = FALSE;
    NSUInteger sensitivity = self.preferences.mouseSensitivity;
    //failsafe:
    if (sensitivity < 10) {
        sensitivity = 10;
    }
    if (sensitivity > 100) {
        sensitivity = 100;
    }
    
    if (event == InputStickMousePadEventDown) {
        if (_deadZone) {
            _deadZoneTimeout = time + DeadZoneTimeoutPeriod;
        }
        
        if (_tapState) {
            NSTimeInterval timeDiff = time - _lastTapTime;
            if ((timeDiff < self.preferences.tapInterval) && (timeDiff > TapMinInterval)) {
                if ([self checkProximityToX:x Y:y]) {
                    if (self.preferences.tapToClick) {
                        _mousepadClicked = TRUE;
                        update = TRUE;
                    }
                }
            } else {
                _tapState = FALSE;
            }
        }
        _lastTapTime = time;
        if (self.preferences.touchScreenMode) {
            [self cancelOutOfRangeTimer];
        }
    } else if (event == InputStickMousePadEventUp) {
        if (_tapState) {
            if (self.preferences.tapToClick) {
                _mousepadClicked = FALSE;
                update = TRUE;
            }
        } else {
            if (time < _lastTapTime + self.preferences.tapInterval) {
                _tapState = TRUE;
            }
        }
        
        _lastTapX = x;
        _lastTapY = y;
        _lastTapTime = time;
        
        if (self.preferences.touchScreenMode) {
            _deadZone = TRUE;
            _deadZoneX = x;
            _deadZoneY = y;
            _deadZoneTimeout = 0;
            
            [self cancelOutOfRangeTimer];
            [self startOutOfRangeTimer];
        }
    } else if (event == InputStickMousePadEventMove) {
        if ((x > 0) && (x < _padWidth) && (y > 0) && (y < _padHeight)) {
            if ((_deadZone) && (_deadZoneTimeout > 0) && (time > _deadZoneTimeout)) {
                _deadZone = FALSE;
            }
            if (_deadZone) {
                if ([self isOutOfDeadZoneWithX:x Y:y]) {
                    _deadZone = FALSE;
                }
            }
            
            if (time > _lastMoveTime + MouseRefreshInterval) {
                // fix:
                if (time > _lastHIDUpdateTime + IdleResetInterval) {
                    _lastX = x;
                    _lastY = y;
                }
                
                _lastHIDUpdateTime = time;
                _lastMoveTime = time;
                
                toMoveX = x - _lastX;
                toMoveY = y - _lastY;
                toMoveX = sensitivity * toMoveX;
                toMoveY = sensitivity * toMoveY;
                toMoveX = toMoveX / 50;
                toMoveY = toMoveY / 50;
                update = TRUE;
                
                _lastX = x;
                _lastY = y;
                if (self.preferences.touchScreenMode &&  !_deadZone) {
                    [self setTouchCoordsToX:x Y:y];
                }
            }
        } else {
            _lastX = 0;
            _lastY = 0;
            //same case in ACTION_UP?
        }
    }
    if (update) {        
        [self sendReportWithX:toMoveX Y:toMoveY scroll:0];
    }
}


#pragma mark - Buttons

- (void)mouseButtonEventWithPressedState:(BOOL)pressed withButton:(InputStickMouseButtons)button {
    if (pressed) {
        if (button == MouseButtonLeft) {
            _buttonStateLeft = TRUE;
        } else if (button == MouseButtonRight) {
            _buttonStateRight = TRUE;
        } else if (button == MouseButtonMiddle) {
            _buttonStateMiddle = TRUE;
        }
        [self sendReportWithX:0 Y:0 scroll:0]; //buttons are already handled
    } else {
        if (button == MouseButtonLeft) {
            _buttonStateLeft = FALSE;
        } else if (button == MouseButtonRight) {
            _buttonStateRight = FALSE;
        } else if (button == MouseButtonMiddle) {
            _buttonStateMiddle = FALSE;
        }
        /*if (self.preferences.touchScreenMode) {
            if (_buttonFix != 0) {
                if (self.mouseHandler != nil) {
                    [self.mouseHandler clickWithButtons:_buttonFix numberOfPress:1];
                }
            }
        }*/
        [self sendReportWithX:0 Y:0 scroll:0];
    }
}


#pragma mark - Scroll Wheel

- (void)scrollWheelEventWithValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode {
    CGFloat tmp = 15 - (_preferences.scrollSensitivity / 10); 
    NSInteger scaledValue = (scrollValue / tmp);
    
    [self manageAutoRotationWithValue:scrollValue withMode:mode];
    if (mode == InputStickMouseInputViewScrollWheelModeIdle) {
        _scrollDirection = 0;
        _scrollClicks = 0;
        _scrollLastValue = 0;
    }
    if (mode == InputStickMouseInputViewScrollWheelModeScroll) {
        NSUInteger n = 0;
        if (_scrollLastValue >= 0) {
            if (scaledValue > _scrollLastValue) {
                n = scaledValue - _scrollLastValue;
                _scrollDirection = 1;
            }
        }
        if (_scrollLastValue <= 0) {
            if (scaledValue < _scrollLastValue) {
                n = _scrollLastValue - scaledValue;
                _scrollDirection = -1;
            }
        }
        _scrollClicks += n;
    }
    
    _scrollLastValue = scaledValue;
}


#pragma mark - Scroll Wheel helpers

- (void)manageAutoRotationWithValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode {
    switch (mode) {
        case InputStickMouseInputViewScrollWheelModeScroll:
        case InputStickMouseInputViewScrollWheelModeIdle:
            _scrollAutoRotationCounter = 0;
            _scrollAutoRotationMode = 0;
            break;
        case InputStickMouseInputViewScrollWheelModeLockedHi:
            if (_scrollAutoRotationMode == 0) {
                _scrollAutoRotationCounter = ScrollAutoRotationDelay / ScrollRefreshInterval;
            }
            _scrollAutoRotationMode = 2;
            break;
        case InputStickMouseInputViewScrollWheelModeLockedLo:
            if (_scrollAutoRotationMode == 0) {
                _scrollAutoRotationCounter = ScrollAutoRotationDelay / ScrollRefreshInterval;
            }
            _scrollAutoRotationMode = 1;
            break;
    }
    
    if (_scrollLastValue < 0) {
        _scrollAutoRotationMode = -_scrollAutoRotationMode;
    }
}

- (void)startScrollTimer {
    if (_scrollTimer == nil) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:((float)ScrollRefreshInterval/1000) target:self selector:@selector(scrollTimerEvent) userInfo:nil repeats:YES];
    }
}

- (void)stopScrollTimer {
    if (_scrollTimer != nil) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)scrollTimerEvent {
    if (_scrollAutoRotationMode && _scrollAutoRotationCounter) {
        _scrollAutoRotationCounter--;
        if (_scrollAutoRotationCounter == 0) {
            _scrollAutoRotationCounter = ScrollAutoRotationInterval / ScrollRefreshInterval; //next event
            
            NSUInteger n = _preferences.scrollSensitivity / 10;
            //failsafe:
            if (n < 1) {
                n = 1;
            }
            
            switch (_scrollAutoRotationMode) {
                case 2:
                    _scrollClicks = n;
                    _scrollDirection = 1;
                    break;
                case 1:
                    _scrollClicks = 1;
                    _scrollDirection = 1;
                    break;
                case -1:
                    _scrollClicks = 1;
                    _scrollDirection = -1;
                    break;
                case -2:
                    _scrollClicks = n;
                    _scrollDirection = -1;
                    break;
            }
        }
    }
    
    if (_scrollClicks) {
        if (_scrollClicks > ScrollMaxClicks) {
            _scrollClicks = ScrollMaxClicks;
        }
        InputStickHIDTransaction *transaction = [InputStickHIDTransaction mouseTransaction];
        for (int i = 0 ; i < _scrollClicks; i++) {
            [transaction addHIDReport:[self.inputStickManager.mouseHandler customReportWithButtons:0x00 x:0x00 y:0x00 scroll:_scrollDirection]];
        }
        [self.inputStickManager.buffersManager addMouseHIDTransaction:transaction flush:TRUE];
        _scrollClicks = 0;
    }
}


#pragma mark - Touch-screen mode helpers

- (void)setTouchCoordsToX:(NSInteger)x Y:(NSInteger)y {
    NSUInteger w = _padWidth;
    NSUInteger h = _padHeight;
    NSUInteger center;
    NSInteger tmp;
    
    center = w/2;
    tmp = center - x;
    tmp = tmp * MousepadRescaleFactor;
    x = (NSInteger)(center - tmp);
    if (x < 0) x = 0;
    if (x > w) x = w;
    
    center = h/2;
    tmp = center - y;
    tmp = tmp * MousepadRescaleFactor;
    y = (NSInteger)(center - tmp);
    if (y < 0) y = 0;
    if (y > h) y = h;
    
    _touchScreenX = (x * 10000 / w);
    _touchScreenY = (y * 10000 / h);
    
    if (_touchScreenX > 10000) _touchScreenX = 10000;
    if (_touchScreenY > 10000) _touchScreenY = 10000;
}

-(void)cancelOutOfRangeTimer {
    if (_outOfRangeTimer != nil) {
        [_outOfRangeTimer invalidate];
    }
    _outOfRangeTimer = nil;
}

- (void)startOutOfRangeTimer {
    _outOfRangeTimer = [NSTimer scheduledTimerWithTimeInterval:((float)OutOfRangeTimeout/1000) target:self selector:@selector(outOfRangeEvent) userInfo:nil repeats:NO];
}

- (void)outOfRangeEvent {
    _outOfRangeTimer = nil;
    [self.inputStickManager.touchScreenHandler goOutOfRangeAtX:_touchScreenX y:_touchScreenY];
    _touchScreenX = -1;
    _touchScreenY = -1;
}


#pragma mark - Mousepad helpers

-(BOOL)checkProximityToX:(NSUInteger)x Y:(NSUInteger)y {
    NSInteger d;
    d = (_lastTapX - x) * (_lastTapX - x);
    d += (_lastTapY - y) * (_lastTapY - y);
    return (d < _proximityThreshold);
}

-(BOOL) isOutOfDeadZoneWithX:(NSUInteger)x Y:(NSUInteger)y {
    NSInteger d;
    d = (_deadZoneX - x) * (_deadZoneX - x);
    d += (_deadZoneY - y) * (_deadZoneY - y);
    return (d > _proximityThreshold);
}

//mousepad clicks should not be included when touchscreen interface is used
- (Byte)getMouseButtonsIncludingMousepadClick:(BOOL)includeMousepadClick {
    Byte buttonByte = 0;
    if (includeMousepadClick && _mousepadClicked) {
        buttonByte |= MouseButtonLeft;
    }
    if (_buttonStateLeft) {
        buttonByte |= MouseButtonLeft;
    }
    if (_buttonStateMiddle) {
        buttonByte |= MouseButtonMiddle;
    }
    if (_buttonStateRight) {
        buttonByte |= MouseButtonRight;
    }
    return buttonByte;
}


#pragma mark - Sending HID reports

- (void)sendReportWithX:(NSInteger)x Y:(NSInteger)y scroll:(NSInteger)toScroll {
    Byte buttonByte = 0;
    
    if (self.preferences.touchScreenMode) {
        if (toScroll != 0) {
            [self.inputStickManager.mouseHandler scroll:toScroll];
        } else {
            if ((_touchScreenX >= 0) && (_touchScreenY >= 0)) { //prevents touchscreen actions after going out of range
                [self.inputStickManager.touchScreenHandler moveTouchPointerToX:_touchScreenX y:_touchScreenY withButtonPressed:_mousepadClicked];
            }
        }
        //mousepad clicks are handled above, use mouse interface for button (mouse buttons below mousepad) clicks
        buttonByte = [self getMouseButtonsIncludingMousepadClick:FALSE];
        if (buttonByte != 0) {
            _mouseInterfaceButtonsPressed = TRUE;
            [self.inputStickManager.mouseHandler sendCustomReportWithButtons:buttonByte x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)toScroll flush:YES];
        } else {
            //release mouse button if pressed
            if (_mouseInterfaceButtonsPressed) {
                _mouseInterfaceButtonsPressed = FALSE;
                [self.inputStickManager.mouseHandler sendCustomReportWithButtons:buttonByte x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)toScroll flush:YES];
            }
        }
    } else {
        buttonByte = [self getMouseButtonsIncludingMousepadClick:TRUE];
        if (x < -127) x = 127;
        if (x > 127) x = 127;
        if (y < -127) y = 127;
        if (y > 127) y = 127;
        if (toScroll < -127) toScroll = 127;
        if (toScroll > 127) toScroll = 127;
        
        [self.inputStickManager.mouseHandler sendCustomReportWithButtons:buttonByte x:(SignedByte)x y:(SignedByte)y scroll:(SignedByte)toScroll flush:YES];
    }
}

@end

