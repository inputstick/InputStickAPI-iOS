/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardHandler.h
 @brief allows to send Keyboard actions
 @discussion Modifier(s) refer to Ctrl, Shift, Alt, GUI (Win) keys. All other keyboard keys are referred to as (non-modifier) keys
 
 Keyboard interface has no feedback from USB host: there is no way of knowing if text is typed/typed correctly/into correct text field.
 It is up to user to provide necessary feedback.
 
 If keyboard input is too fast for USB host (results in missing characters), use report multiplier (typing speed) to reduce typing speed.
 
 Always make sure to use the same keyboard layout as USB host.
 When pressing individual keys, key labels always refer to US keyboard.
 Example: if you want to press "Y" key and host uses German layout, you have to use KEY_Z, because that label is used on US keyboard layout.
 */

#import <Foundation/Foundation.h>
#import "NSNotificationCenter+InputStickStatusUpdate.h"
#import "InputStickHIDHandler.h"

@class InputStickManager;
@class InputStickHIDReport;
@protocol InputStickKeyboardLayoutProtocol;


typedef NS_ENUM(Byte, InputStickKeyboardLEDs) {
    NumLockLED = 0x01,
    CapsLockLED = 0x02,
    ScrollLockLED = 0x04
};

typedef NS_ENUM(Byte, InputStickKeyboardModifiers) {
    CTRL_LEFT = 0x01,
    SHIFT_LEFT = 0x02,
    ALT_LEFT = 0x04,
    GUI_LEFT = 0x08,
    CTRL_RIGHT = 0x10,
    SHIFT_RIGHT = 0x20,
    ALT_RIGHT = 0x40,
    GUI_RIGHT = 0x80
};

typedef NS_ENUM(Byte, InputStickKeyboardKeys) {
    KEY_NONE               = 0x00,
    
    KEY_A                  = 0x04,
    KEY_B                  = 0x05,
    KEY_C                  = 0x06,
    KEY_D                  = 0x07,
    KEY_E                  = 0x08,
    KEY_F                  = 0x09,
    KEY_G                  = 0x0A,
    KEY_H                  = 0x0B,
    KEY_I                  = 0x0C,
    KEY_J                  = 0x0D,
    KEY_K                  = 0x0E,
    KEY_L                  = 0x0F,
    KEY_M                  = 0x10,
    KEY_N                  = 0x11,
    KEY_O                  = 0x12,
    KEY_P                  = 0x13,
    KEY_Q                  = 0x14,
    KEY_R                  = 0x15,
    KEY_S                  = 0x16,
    KEY_T                  = 0x17,
    KEY_U                  = 0x18,
    KEY_V                  = 0x19,
    KEY_W                  = 0x1A,
    KEY_X                  = 0x1B,
    KEY_Y                  = 0x1C,
    KEY_Z                  = 0x1D,
    
    KEY_1                  = 0x1E,
    KEY_2                  = 0x1F,
    KEY_3                  = 0x20,
    KEY_4                  = 0x21,
    KEY_5                  = 0x22,
    KEY_6                  = 0x23,
    KEY_7                  = 0x24,
    KEY_8                  = 0x25,
    KEY_9                  = 0x26,
    KEY_0                  = 0x27,
    
    KEY_ENTER              = 0x28,
    KEY_ESCAPE             = 0x29,
    KEY_BACKSPACE          = 0x2A,
    KEY_TAB                = 0x2B,
    KEY_SPACEBAR           = 0x2C,
    
    KEY_MINUS              = 0x2D,
    KEY_EQUALS             = 0x2E,
    KEY_LEFT_BRACKET       = 0x2F,
    KEY_RIGHT_BRACKET      = 0x30,
    KEY_BACKSLASH          = 0x31,
    KEY_HASH_NON_US        = 0x32, //not used
    KEY_SEMICOLON          = 0x33,
    KEY_APOSTROPHE         = 0x34,
    KEY_GRAVE              = 0x35,
    KEY_COMA               = 0x36,
    KEY_DOT                = 0x37,
    KEY_SLASH              = 0x38,
    KEY_CAPS_LOCK          = 0x39,
    
    KEY_F1                 = 0x3A,
    KEY_F2                 = 0x3B,
    KEY_F3                 = 0x3C,
    KEY_F4                 = 0x3D,
    KEY_F5                 = 0x3E,
    KEY_F6                 = 0x3F,
    KEY_F7                 = 0x40,
    KEY_F8                 = 0x41,
    KEY_F9                 = 0x42,
    KEY_F10                = 0x43,
    KEY_F11                = 0x44,
    KEY_F12                = 0x45,
    
    KEY_PRINT_SCREEN       = 0x46,
    KEY_SCROLL_LOCK        = 0x47,
    KEY_PASUE              = 0x48,
    KEY_INSERT             = 0x49,
    KEY_HOME               = 0x4A,
    KEY_PAGE_UP            = 0x4B,
    KEY_DELETE             = 0x4C,
    KEY_END                = 0x4D,
    KEY_PAGE_DOWN          = 0x4E,
    
    KEY_ARROW_RIGHT        = 0x4F,
    KEY_ARROW_LEFT         = 0x50,
    KEY_ARROW_DOWN         = 0x51,
    KEY_ARROW_UP           = 0x52,
    
    KEY_NUM_LOCK           = 0x53,
    KEY_NUM_SLASH          = 0x54,
    KEY_NUM_STAR           = 0x55,
    KEY_NUM_MINUS          = 0x56,
    KEY_NUM_PLUS           = 0x57,
    KEY_NUM_ENTER          = 0x58,
    KEY_NUM_1              = 0x59,
    KEY_NUM_2              = 0x5A,
    KEY_NUM_3              = 0x5B,
    KEY_NUM_4              = 0x5C,
    KEY_NUM_5              = 0x5D,
    KEY_NUM_6              = 0x5E,
    KEY_NUM_7              = 0x5F,
    KEY_NUM_8              = 0x60,
    KEY_NUM_9              = 0x61,
    KEY_NUM_0              = 0x62,
    KEY_NUM_DOT            = 0x63,
    
    KEY_BACKSLASH_NON_US   = 0x64,
    KEY_APPLICATION        = 0x65
};

typedef NS_ENUM(NSUInteger, InputStickTypingSpeed) {
    InputStickTypingSpeedFastest = 0, /*! fastest possible typing speed, not compatible with all USB hosts */
    InputStickTypingSpeedNormal = 1, /*! default typing speed */
    InputStickTypingSpeed050 = 2, /*! 50% typing speed */
    InputStickTypingSpeed030 = 3, /*! 33% typing speed */
    InputStickTypingSpeed025 = 4, /*! 25% typing speed */
    InputStickTypingSpeed020 = 5, /*! 20% typing speed */
    InputStickTypingSpeed010 = 10, /*! 30% typing speed */
};


@interface InputStickKeyboardHandler : NSObject <InputStickHIDHandler, InputStickStatusUpdateNotificationObserver>

/*! state of NumLock keyboard LED */
@property(nonatomic, readonly) BOOL numLockOn;
/*! state of CapsLock keyboard LED */
@property(nonatomic, readonly) BOOL capsLockOn;
/*! state of ScrollLock keyboard LED */
@property(nonatomic, readonly) BOOL scrollLockOn;


- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager;

#pragma mark - Custom Report

/*!
 @brief creates Keyboard HID report
 @param modifiers pressed modifier keys
 @param key pressed key
 @return Keyboard InputStickHIDReport
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard) 
 */
- (InputStickHIDReport *)customReportWithModifiers:(Byte)modifiers key:(Byte)key;

/*!
 @brief queues Keyboard HID report
 @param modifiers pressed modifier keys
 @param key pressed key
 @param sendASAP if TRUE HID Keyboard buffer will be flushed
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard)
 */
- (void)sendCustomReportWithModifiers:(Byte)modifiers key:(Byte)key sendASAP:(BOOL)sendASAP;

/*!
 @brief queues Keyboard HID report
 @param modifiers pressed modifier keys
 @param key pressed key
 @param multiplier reduction of typing speed
 @param sendASAP if TRUE HID Keyboard buffer will be flushed
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard).
 Multiplier reduces typing speed by multiplying HID reports, see InputStickTypingSpeed
 */
- (void)sendCustomReportWithModifiers:(Byte)modifiers key:(Byte)key multiplier:(NSUInteger)multiplier sendASAP:(BOOL)sendASAP;


#pragma mark - Press and release keys

/*!
 @brief presses and releases modifier+key
 @param modifiers pressed modifier keys
 @param key pressed key
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard).
 */
- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key;

/*!
 @brief presses and releases modifier+key
 @param modifiers pressed modifier keys
 @param key pressed key
 @param sendASAP if TRUE HID Keyboard buffer will be flushed
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard).
 */
- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key sendASAP:(BOOL)sendASAP;

/*!
 @brief presses and releases modifier+key
 @param modifiers pressed modifier keys
 @param key pressed key
 @param speed typing speed
 @param sendASAP if TRUE HID Keyboard buffer will be flushed
 @discussion See InputStickKeyboardModifiers and InputStickKeyboardKeys.
 Key parameter always refers to US layout key labels (example: if USB host uses German keyboard layout you must use KEY_Z to get Y character, because that is the label on US keyboard).
 Typing speed is controlled by multiplying HID reports, see InputStickTypingSpeed
 */
- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key typingSpeed:(NSUInteger)speed sendASAP:(BOOL)sendASAP;


#pragma mark - Type text

/*!
 @brief types provided text assuming en-US keyboard layout
 @param text text to type
 */
- (void)typeText:(NSString *)text;

/*!
 @brief types provided text using provided keyboard layout
 @param text text to type
 @param keyboardLayout keyboard layout to use
 @discussion always make sure to use keyboard layout compatible with keyboard layout used by USB host
 */
- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout;

/*!
 @brief types provided text using provided keyboard layout
 @param text text to type
 @param keyboardLayout keyboard layout to use
 @param speed typing speed
 @discussion always make sure to use keyboard layout compatible with keyboard layout used by USB host.
 Typing speed is controlled by multiplying HID reports, see InputStickTypingSpeed
 */
- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout typingSpeed:(NSUInteger)speed;

/*!
 @brief types provided text using provided keyboard layout while holding provided modifier keys
 @param text text to type
 @param keyboardLayout keyboard layout to use
 @param modifiers modifier keys to hold while typing
 @param speed typing speed
 @param sendASAP if TRUE HID Keyboard buffer will be flushed
 @discussion always make sure to use keyboard layout compatible with keyboard layout used by USB host.
 Typing speed is controlled by multiplying HID reports, see InputStickTypingSpeed.
 See InputStickKeyboardModifiers.
 */
- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout modifiers:(Byte)modifiers typingSpeed:(NSUInteger)speed sendASAP:(BOOL)sendASAP;

@end
