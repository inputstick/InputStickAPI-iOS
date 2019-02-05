/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickMouseInputView.h
 @brief UIView representing mousepad area that can transform user actions (touch and movement events) to Mouse or Touch Screen events
 */

#import <UIKit/UIKit.h>

@class InputStickMouseInputView;

typedef NS_ENUM(NSUInteger, InputStickMouseInputViewMode) {
    InputStickMouseInputViewModeMousePad = 1,
    InputStickMouseInputViewModeScrollWheel = 2,
};

typedef NS_ENUM(NSUInteger, InputStickMouseInputViewScrollWheelMode) {
    InputStickMouseInputViewScrollWheelModeIdle = 0, /*! scroll wheel is in dead zone */
    InputStickMouseInputViewScrollWheelModeScroll = 1, /*! scroll wheel moved */
    InputStickMouseInputViewScrollWheelModeLockedLo = 2, /*! scroll wheel should be constantly rotating at low rate */
    InputStickMouseInputViewScrollWheelModeLockedHi = 3, /*! scroll wheel should be constantly rotating at high rate */
};


@protocol InputStickMouseInputViewDelegate <NSObject>
- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveMoveAtPoint:(CGPoint)movePoint;
- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveScrollValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode;
- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchChange:(BOOL)touched;
- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didReceiveTouchAtPoint:(CGPoint)touchPoint;
- (void)inputSticMouseInputView:(InputStickMouseInputView *)view didEnterMode:(InputStickMouseInputViewMode)mode;

@end

@interface InputStickMouseInputView : UIView

/*! delegate for mousepad events */
@property(nonatomic, strong) id <InputStickMouseInputViewDelegate> delegate;
/*! info label will be displayed on mousepad area */
@property(nonatomic, strong, readonly) UILabel *infoLabel;
/*! mousepad area aspect ratio */
@property(nonatomic) float ratio;
/*! color of scroll wheel UI */
@property(nonatomic, strong) UIColor *interfaceColor;
/*! color of scroll wheel marker */
@property(nonatomic, strong) UIColor *scrollPositionMarkerColor;
/*! color of scroll wheel rotation lock markers */
@property(nonatomic, strong) UIColor *scrollLockMarkerColor;
/*! scroll wheel gesture (2fingers touch) enabled */
@property(nonatomic) BOOL scrollEnabled;

- (instancetype)initWithRatio:(float)ratio;

@end
