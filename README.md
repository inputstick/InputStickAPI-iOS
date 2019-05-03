#  InputStickAPI (iOS/macOS)
## About InputStick
InputStick is an Android and iOS compatible USB receiver. It allows to use your smartphone as a wireless keyboard, mouse, multimedia and game controller. 

[![iOS API demo video](http://img.youtube.com/vi/GxqTSWtliRA/0.jpg)](http://www.youtube.com/watch?v=GxqTSWtliRA)

[InputStick website](http://inputstick.com)


### How does it work?
InputStick acts as a proxy between USB host and iOS/Android device:

`iOS/Android device ←(Bluetooth)→ InputStick ←(USB)→ USB host (PC)`

USB host sees InputStick as a generic HID device, it knows nothing about Bluetooth interface and mobile app. As a result of that:

* InputStick works with any USB host (that supports generic HID keyboard and mouse): PC, DVRs, TVs, embedded systems, consoles, etc.
* no custom drivers are necessary
* you do not have to install any additional software or configure USB host
* just plug InputStick into USB port and in a few seconds it is ready to go (note: macOS requires very short configuration to detect keyboard layout)


### Requirements
* iOS apps: iOS 9.0 or later, iPhone 4S or later
* macOS apps: macOS 10.10 or later, Bluetooth


### Security
Communication with InputStick can be encrypted using AES-128 and authenticated with HMAC-SHA256.
User can setup password protection using [InputStickUtility application](http://inputstick.com/inputstickutility)


### Limitations and things to consider
Bluetooth-related:

* establishing Bluetooth connection takes 1-2 seconds
* data transfer rate is ~2-10 KBps
* Bluetooth introduces few ms latency
* walls and other obstacles will decrease Bluetooth performance

USB-related:

* InputStick types text by emulating user pressing keyboard keys. It does not paste text or send unicode characters
* InputStick gets no feedback from USB host. Think of it as of blind person with USB keyboard. It is up to user to make sure that USB host is ready for typing, that correct text field is selected etc.
* InputStick knows nothing about USB host. User must provide necessary info (most importantly, what keyboard layout is used by the USB host)
* when InputStick is plugged for the very first time, it may take a few seconds before USB host installs generic HID drivers and enumerates the device

Example:
App uses InputStick to type webpage address when a button is pressed. Before user presses the button he/she must first:

* configure typing options (set the same keyboard layout as used by USB host)
* make sure that web browser is opened
* make sure that address text field is selected


## Getting started
### iOS
* add InputStickAPI to your iOS app project
* add `NSBluetoothPeripheralUsageDescription` to Info.plist file
* use `InputStickMenuTableViewController` to take care of most of InputStick-related tasks (easy way, or provide your own implementation) 
* see InputStickDemo app for an example of how to use InputStickAPI

### macOS:
* add InputStickAPI to your macOS app project
* remove `iOS` folder
* macOS helper classes and demo project are coming soon. At this moment you'll have to provide your own implementation

### InputStickDemo iOS app
The Demo application will show you how to:

* create and initialize `InputStickManager`, implement `InputStickManagerDelegate` methods
* manage connection, check connection state
* perform HID actions (press keys, type text, move mouse etc.)
* implement mousepad area, intercept characters from soft keyboard, implement simple gamepad
* check state of HID buffers, cancel HID actions
* send custom packets to InputStick and intercept packets received from InputStick


## App Store review
Before you submit your application for App Store review:

* double-check if `NSBluetoothPeripheralUsageDescription` was added to Info.plist file
* prepare video showing how your app interacts with InputStick (real hardware), Apple will request it
* use `[inputStickManager setDummyConnectedState]` to pretend to be connected to InputStick when taking screenshots using iOS emulator

### Encryption
After adding the API to your application, you have to answer yes to following questions:

* "Does your product contain encryption?"
* "Does your product qualify for any exemptions provided under category 5 part 2?"

Read [Apple Export compliance documentation for encryption ](https://help.apple.com/app-store-connect/#/devc3f64248f) for more details. If your app is already uses encryption (HTTPS etc.) then adding the API changes nothing. If you want to remove encryption support, see `InputStickEncryptionManager.h`. If you do this, your application will show error message when it connects to password protected InputStick device.

## InputStickManager
InputStickManager manages InputStick connection, HID handlers, HID buffers, device database. Create an instance of InputStickManager when application is launched:
`inputStickManager = [[InputStickManager alloc] init];`

### InputStickManager Delegate
You must set delegate for the InputStickManager:
`inputStickManager.delegate = self`

provide implementation for delegate methods:

`- (void)inputStickManager:(InputStickManager *)inputStickManager presentErrorDialog:(NSError *)error;`
`- (void)inputStickManager:(InputStickManager *)inputStickManager presentKeyRemovedDialog:(InputStickDeviceData *)deviceData;`
`- (void)inputStickManager:(InputStickManager *)inputStickManager presentProvideKeyDialog:(InputStickDeviceData *)deviceData request:(InputStickKeyRequest)request;`
`- (void)inputStickManager:(InputStickManager *)inputStickManager presentFirmwareUpdateDialog:(InputStickDeviceData *)deviceData;`

You can use helper methods available in  `InputStickUI.h`, also see `InputStickDemo` for an example.


## User interface & preferences
The API provides several ready to use components that can handle most of InputStick-related UI:

* `InputStickMenuTableViewController` allows to manage InputStick connection, manage saved InputStick devices, manage InputStick-related preferences (keyboard layout etc.)
* `InputStickTheme` allows to customize API Menu ViewControllers
* `InputStickUI` helper class for InputStick-related dialogs & actions
* `InputStickBarButtonItem` allows to connect most recently used device/disconnect with a single click

Preferences that are managed by InputStick Menu can be accessed in a following way:
`preferences = [[InputStickPreferences alloc] init];`
`[preferences loadFromUserDefaults];`

set reference when showing the Menu, so that fields get updated when user makes changes:
`((InputStickMenuTableViewController *)vc).preferences = preferences;`


## Connection
### Managing connection
Use InputStickManager to manage connection:

`[inputStickManager connectToLastInputStick];`
`[inputStickManager connectToNearsetStoredInputStick];`
`[inputStickManager connectToInputStickWithIdentifier:identifier];`
`[inputStickManager disconnectFromInputStick];`

If there are any actions that require user attention, InputStickManager Delegate methods will be called. 
To learn how to get Bluetooth identifiers, see sections below.


### Checking connection state
To get current connection state:
`inputStickManager.connectionState`

you can also register for Connection state notifications, see **Notifications** section. 

Connection states:

* `InputStickDisconnected` - not connected
* `InputStickConnecting` - waiting for Bluetooth connection
* `InputStickInitializing` - initializing InputStick firmware
* `InputStickWaitingForUSB` - firmware initialized, can NOT send HID actions yet (USB not configured by host)
* `InputStickReady` - connected and ready to send HID actions

You should always check if InputStick is "Ready" before executing any HID actions.
Once firmware initialization is completed, connection state can change between "Ready"/"WaitingForUSB" (for example, if USB host reboots). 
Note: Ready state means that USB host has enumerated InputStick and set it as configured, but in some cases it may take few more seconds (wait until HID drivers are installed) before HID actions will be accepted by host. Unfortunately, InputStick has no way of knowing when this happens - it is up to user to provide feedback.


### Scanning for peripherals
When connecting to a InputStick device for the very first time, you need to know its Bluetooth Identifier. To scan for nearby InputStick devices:
`[inputStickManager startBluetoothPeripheralScanWithTimeout:YES];`
and register as `InputStickPeripheralScanNotificationObserver` see **Notifications** section below.

You can also use `InputStickMenuTableViewController` to take care of Bluetooth peripheral scan. 

### Device database
InputStickAPI saves information (name, Bluetooth Identifier, firmware version, encryption key) for all InputStick devices that it connected to in internal database. 
You can use the database if you want to connect to a particular device (by getting its Bluetooth Identifier), database can be accessed from InputStickManager:
`inputStickManager.deviceDB`

`InputStickMenuTableViewController` allows user to manage saved devices (display info, assign custom names, delete devices).

### Connection-related UI
* always assume that app user may have several InputStick devices and provide a way to connect to manually selected device
* provide an easy way to reconnect to most recently used device or user-selected default device
* provide auto-connect option (when app becomes active) if the app is designed to be mainly used with InputStick connected
* disable InputStick-related UI actions (type etc.) when not connected or show not connected error messages

## HID Handlers
HID Handlers allows you to perform actions using particular HID Interface. The handlers can be accessed from InputStickManager, for example:
`inputStickManager.keyboardHandler`
`inputStickManager.mouseHandler`

Before you execute any HID action you should check if InputStickConnectionState is InputStickReady and display error message if not.  You can also use helper methods from `InputStickUI.h`

### Keyboard Handler
Allows to send USB HID Keyboard Interface actions. 

Usage example:
Press "Z" key:
`[inputStickManager.keyboardHandler sendCustomReportWithModifiers:0 key:KEY_Z flush:TRUE];`

Type "xYz" on a USB host using German keyboard layout:
`layout = [InputStickKeyboardUtils keyboardLayoutWithCode:@"de-DE"];`
`[inputStickManager.keyboardHandler typeText:@"xYz" withKeyboardLayout:_layout modifiers:0 typingSpeed:1 flush:YES];`

Keyboard actions are affected by USB host keyboard settings (keyboard layout, key repeat rate).

Modifier keys / keys:

* modifier keys refer to: Ctrl, Alt, Shift, GUI (Windows / Command key)
* non-modifier keys: all keys that are not modifier keys

Keyboard layouts:

* when pressing individual keys, key labels refer to US keyboard layout. Example: key next to "Tab" key should be always referred to as KEY_Q, even if in French keyboard layout this key is labeled as "A"
* when typing text it is necessary to provide keyboard layout that is used by USB host. In the example above, if "fr-FR" layout is specified, API will know that to get "Q" character it is necessary to press KEY_A
* see `InputStickKeyboardUtils.h` to get list of supported keyboard layouts, get key labels etc. 
* currently supported keyboard layouts: `cs-CZ, da-DK, de-CH, de-DE, el-GR, en-DV (Dvorak), en-GB, en-US, es-ES, fi-FI, fr-BE, fr-CA, fr-CH, fr-FR, he-IL, hr-HR, hu-HU, it-IT, nb-NO, nl-NL, pl-PL, pt-BT, pt-PT, ru-RU, sk-SK, sv-SV`

Typing speed:

* if USB host is not able to accept fast keyboard input (missing characters) you should decrease typing speed
* typing speed is reduced by multiplying number of sent HID reports (to simulate key being held for a longer period of time)
* if value of multiplier is 5, typing speed will be 20% of default typing speed
* if value of multiplier is 0, fastest possible typing speed will be used, however it is not guaranteed to work correctly with all USB hosts!

Keyboard LEDs:

* state of keyboard LEDs (NumLock, CapsLock, ScrollLock) is common for all connected keyboards on hosts running Windows: if user enables CapsLock using physical keyboard it will also affect text typed using InputStick 
* state of keyboard LEDs is individual for each keyboard on Linux and macOS, if user enables CapsLock using physical keyboard it will not affect text typed using InputStick
* to check current state of keyboard LEDs: `inputStickManager.keyboardHandler.numLockOn` etc.
* if you want to be notified when state of LEDs is changed, see **Notifications** section


### Mouse Handler
Allows to send USB HID Mouse Interface actions. 

Usage example:
move cursor to the right with left mouse button pressed (remember to release button):
`[inputStickManager.mouseHandler sendCustomReportWithButtons:MouseButtonLeft x:0 y:50 scroll:0 flush:YES];`

The handler emulates mouse with 8 buttons and scroll wheel. 
Mouse Interface uses relative screen coordinates (changes cursor position by dx,dy).  It is recommended to use Mouse Interface for tasks like real-time remote control, when user moves the cursor.
Mouse actions are affected by USB host mouse settings (sensitivity, acceleration, screen resolution).
See `iOS\Mousepad` if you want to implement mousepad area in your application.

### TouchScreen Handler
Allows to send USB HID Touch Screen Interface actions. 

Usage example:
click (move cursor to and press) center of the screen (remember to release button):
`[inputStickManager.touchScreenHandler moveTouchPointerToX:5000 y:5000 withButtonPressed:YES];`

Touch Screen Interface uses absolute screen coordinates (moves cursor to x,y). It is recommended to use Touch Screen Interface for tasks like macros, when you need a guarantee that cursor will be moved to desired point, no matter its initial location.
HID Touch Screen is supported by PCs running most popular systems (Windows, Linux, macOS) but may not be supported by other USB hosts (DVRs, smart TVs, etc.). OS may show additional UI (touch input etc.) when touch-screen interface actions are executed

### Consumer Handler
Allows to send USB HID Consumer Control Interface actions: multimedia actions (playback and volume control), launch system default apps (web browser) etc.

Usage example:
mute system volume:
`[inputStickManager.consumerHandler consumerActionWithUsage:ConsumerActionVolumeMute];`

[Here you can find list of all HID usages](https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf ). See Consumer Page (0x0C) section.
Consumer Control actions can work differently depending on USB host, some of them may be not supported at all. For example: increasing volume by 1 level may result in increasing volume by 20% (if there are 5 volume levels) or by 1% (if there are 100 volume levels). 

### Gamepad Handler
Allows to send USB HID Gamepad Interface actions.

Usage example:
press gamepad buttons:
`buttons = GamepadButton2 | GamepadButton3;`
`[inputStickManager.gamepadHandler sendCustomReportWithButtons:buttons axisX:0 axisY:0 axisZ:0 axisRX:0];`

The handler emulates gamepad with 4 axis and 16 buttons.
Gamepad Interface works in a different way from other HID Interfaces. Gamepad HID reports are being written directly to USB endpoint (not buffered) to achieve minimum latency. If endpoint is busy, the report is lost, but because of how gamepads are used, this should not be a problem.


## HID Report Buffers
HID Report Buffers are used to queue HID reports. Buffers can be accessed from InputStickManager.
If a buffer is not empty, there are HID reports still waiting to be polled by USB host, for example: keyboard interface is still typing text.
`inputStickManager.keyboardBufferEmpty`

Clear HID buffer to cancel all actions, for example, cancel typing text: 
`[inputStickManager clearKeyboardBuffer];`

You can receive notifications when a buffer becomes empty, see **Notifications** section.
For each interface there is Local Buffer (API) and Remote Buffer (InputStick).  See **More details** section.


## Notifications
### Connection state notifications
`NSNotificationCenter+InputStickConnection.h`

To get notified when connection state changes:
`- (void)registerForInputStickConnectionNotificationsWithObserver:(id <InputStickConnectionNotificationObserver>)observer;`

and provide implementation for:
`- (void)didUpdateInputStickConnectionState:(NSNotification *)notification;`

### Peripheral scan notifications
`NSNotificationCenter+InputStickPeripheralScan.h`

To get notified when peripheral scan is started, stopped and when list of discovered peripherals is updated:
`- (void)registerForInputStickPeripheralScanNotificationsWithObserver:(id <InputStickPeripheralScanNotificationObserver>)observer;`

and provide implementation for:
`- (void)postDidUpdateInputStickPeripheralsList:(NSMutableArray<InputStickPeripheralInfo *> *)foundPeripherals;`
`- (void)postDidStartInputStickPeripheralScan;`
`- (void)postDidFinishInputStickPeripheralScan;`
`- (void)postDidTimeoutInputStickPeripheralScan;`

### Status update notifications
`NSNotificationCenter+InputStickStatusUpdate.h`

To get notified when a HID Buffer becomes empty or when state of keyboard LEDs is changed.
`- (void)registerForInputStickStatusUpdateNotificationsWithObserver:(id <InputStickStatusUpdateNotificationObserver>)observer;`

and provide implementation for callback method for the status update that you are interested in, for example:
`- (void)didEmptyInputStickKeyboardBufferNotification;`

### Packet notifications
`NSNotificationCenter+InputStickPacket.h`

To get notified when a data packet from InputStick is received:
`- (void)registerForInputStickPacketNotificationsWithObserver:(id <InputStickPacketNotificationObserver>)observer;`

and provide implementation for:
`- (void)didReceiveInputStickPacket:(NSNotification *)notification;`


## More details
[Learn more about USB HID: USB HID1.11 pdf](https://www.usb.org/sites/default/files/documents/hid1_11.pdf)

### HID Interfaces:
By default, InputStick declares following USB Interfaces:

* HID Keyboard Interface (HID Keyboard Report)
* HID Mouse Interface (HID Mouse Report)
* HID Consumer Control Interface (HID Consumer Control Page Report, HID System Page Report, HID TouchScreen Report, HID Gamepad Report) 
* HID Raw Interface (HID Raw Report). Raw HID allows to send/receive raw data bytes via USB HID. Raw HID is not supported in current implementation. 

Each interfaces has 4ms poll rate (with exception of 64 ms for Raw HID) - USB host will check if there is new HID report available. Interfaces are independent from each other. InputStickUtility application can be used to modify default configuration (hide some of interfaces).

### HID Report:
USB HID Interface reports its state (change of state) in a form of HID Reports. Example:

* HID Keyboard Report (8 bytes): modifiers, reserved (0x00), key1, key2, key3, key4, key5, key6
* HID Mouse Report (4 bytes): buttons, dx, dy, scroll

Host assumes that state of buttons does not change until next report is available. That is why in case of keyboard keys or mouse buttons it is necessary to send report releasing all keys or mouse buttons.

### HID Report Transaction:
HID Reports can be grouped into HID Report Transactions. If possible, all reports from a transaction will be sent to InputStick in a single packet. This guarantees that either all reports or none will be received. As a result, using transactions allows to prevent situations when a keyboard key is pressed and not released because of loosing Bluetooth connection or app crash.   

### HID Report Buffers:
Most actions generate several HID reports (example: to type "a" you need two HID Keyboard reports: press "a" key, then release it). Since USB host polls a single HID report at a time it is necessary to queue HID reports.
Because of latency introduced by Bluetooth, for each HID Interface there is a Local Buffer (API) and Remote Buffer (InputStick):
`HID Handler action → generates n * HID Report → local Report Buffer (API) → Bluetooth → remote Report Buffer (InputStick) → USB host`

InputStick periodically reports about available space in its (remote) buffers and then API sends next set of HID reports from its (local) buffer. 

### InputStick Packets:
[InputStick Protocol Documentation can be downloaded from here.](http://inputstick.com/download)

To send custom data packet to InputStick:

* create `InputStickTxPacket`
* provide required parameters (command byte, parameter byte, payload bytes)
* set options (requires response etc.)
* send the packet `[inputStickManager sendPacket:packet]`

To receive data from InputStick, see **Notifications** section
