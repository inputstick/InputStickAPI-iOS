/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickMouseSupport.h
 @brief helper class that can be used to process user actions from InputStickMouseInputView
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InputStickMouseInputView.h"

typedef NS_ENUM(Byte, InputStickMouseButtons);
@class InputStickManager;
@class InputStickPreferences;

typedef NS_ENUM(NSUInteger, InputStickMousePadEvent) {
    InputStickMousePadEventUp,
    InputStickMousePadEventDown,
    InputStickMousePadEventMove
};

@interface InputStickMouseSupport : NSObject <InputStickMouseInputViewDelegate>

@property(nonatomic, weak) InputStickManager *inputStickManager;
/*! mousepad area preferences (mode, sensitivity etc.) */
@property(nonatomic, weak) InputStickPreferences *preferences;

/*! TRUE if mousepad area is pressed (same as left mouse button click) */
@property(nonatomic, readonly) BOOL mousepadClicked;
/*! TRUE if left mouse button is pressed */
@property(nonatomic, readonly) BOOL buttonStateLeft;
/*! TRUE if middle mouse button is pressed */
@property(nonatomic, readonly) BOOL buttonStateMiddle;
/*! TRUE if right mouse button is pressed */
@property(nonatomic, readonly) BOOL buttonStateRight;
/*! x coordinate of last touch-screen action */
@property(nonatomic, readonly) NSUInteger touchX;
/*! y coordinate of last touch-screen action */
@property(nonatomic, readonly) NSUInteger touchY;


#pragma mark - Setup

/*!
 @brief sets up mouse support for provided mousepad view
 @param inputView mousepad view
 @discussion use each time mousepad view changes its layout
 */
- (void)setupWithInputView:(UIView *)inputView;

/*!
 @brief releases mouse buttons, touch-screen stylus (finger) goes out of range
 @discussion use when mousepad area is no longer visible
 */
- (void)cleanUp;


#pragma mark - Mousepad area

/*!
 @brief sets current mode of mousepad area
 @param mode current mousepad area mode
 @discussion should be called when mousepad area switches its mode between mousepad and scroll wheel
 */
- (void)mousePadModeChanged:(InputStickMouseInputViewMode)mode;

/*!
 @brief processes mousepad area event
 @param event type of event
 @param x x coordinate of event
 @param y y coordinate of event
 */
- (void)mousePadEvent:(InputStickMousePadEvent)event atX:(NSUInteger)x Y:(NSUInteger)y;


#pragma mark - Buttons

/*!
 @brief processes mouse button event
 @param pressed TRUE if button is in pressed state
 @param button mouse button
 @discussion see InputStickMouseHandler for mouse buttons
 */
- (void)mouseButtonEventWithPressedState:(BOOL)pressed withButton:(InputStickMouseButtons)button;


#pragma mark - Scroll Wheel

/*!
 @brief processes scroll wheel event
 @param scrollValue position of scroll wheel
 @param mode scroll wheel mode
 @discussion scrollValue is distance between current position and center location of scroll wheel:
 */
- (void)scrollWheelEventWithValue:(CGFloat)scrollValue withMode:(InputStickMouseInputViewScrollWheelMode)mode;

@end
