# InputStickAPI
InputStickAPI

## Project Setup

- Clone repository: `git clone git@github.com:InputStick/InputStickAPI-ios.git`

## Getting started:

### ISManager:
To start using the Input Stick you have to first create an instance of ISManager.
You also need to specify a delegate which implements protocol: `ISManagerDelegate`.

Create and setup an ISManager:

```
self.inputStickManager = [[ISManager alloc] init];
self.inputStickManager.delegate = self;
```

Establish a connection using:

```
- (void)connectToInputStickUsingStoredIdentifier:(BOOL)useStoredIdentifier;
```
 
You can monitor the device connection status by checking the `inputStickState` property of ISManager or register for connection notifications described later.
During the connection process the API uses a selection view controller (to select a proper BlueTooth device), which has to be presented using delegate method:

```
- (void)inputStickManager:(ISManager *)inputStickManager presentViewController:(UIViewController *)deviceSelectionViewController;
```

In order to use custom view controller you can implement:

```
- (UIViewController <ISDeviceSelectionViewControllerProtocol> *)selectionViewControllerForConnectionManager:(ISConnectionManager *)connectionManager withInputStickManager:(ISManager *)inputStickManager;
```

### HID Handlers
Normally all communication with an Input Stick device is done via device handlers (Keyboard, Mouse, Consumer or Gamepad).
Depending on the type of data, packages will be send in queues (keyboard, mouse, consumer) or all at once (gamepad).

A handler should be created using the default init method, i.e.:

```
- (instancetype)initWithInputStickManager:(ISManager *)manager;
```

#### Keyboard:
To write text use one of the methods:

```
- (void)sendText:(NSString *)text;
- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout;
- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout multiplier:(NSInteger)multiplier;
```

#### Mouse:

```
- (void)sendMoveToX:(SignedByte)x y:(SignedByte)y;
- (void)sendScroll:(SignedByte)scrollValue;
- (void)sendPressedButtons:(Byte)buttons numberOfPress:(NSInteger)numberOfPresses multiplier:(NSInteger)multiplier;
```

#### Consumer:

```
- (void)consumerActionWithUsage:(ISConsumerActions)usage;
- (void)systemActionWithUsage:(ISSystemActions)usage;
```

Definitions of consumer and system actions are available in `ISConsumerHandler.h`

#### Gamepad:
You can update the state of the gamepad using:

```
- (void)sendCustomReportWithButtons:(GamepadButtons)buttons axisX:(SignedByte)x axisY:(SignedByte)y axisZ:(SignedByte)z axisRX:(SignedByte)rx;
```

### Notifications
API offers basic notifications about the device connection and status updates.

Connection Status:
* ISWillStartConnectingPeripheralNotificationName
* ISDidFinishConnectingPeripheralNotificationName
* ISDidFinishConnectingInputStickNotificationName
* ISDidDisconnectInputStickNotificationName;

InputStick device status:
* ISDidUpdateDeviceBuffersNotificationName
* ISDidUpdateKeyboardLedsNotificationName

You can either register for specific notifications or use registration methods defined in categories of NSNotificationCenter:

* NSNotificationCenter+Connection.h

```
- (void)registerForConnectionNotificationsWithObserver:(id <ConnectionNotificationObserver>)observer;
```

* NSNotificationCenter+DeviceStatus.h

```
- (void)registerForDeviceStatusNotificationsWithObserver:(id <ResponseParsingNotificationObserver>)observer;
```

In both cases there are corresponding `unregister` methods. 
