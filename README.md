# InputStickAPI
InputStickAPI

## Project Setup

- Clone repository: `git clone git@github.com:wiecek/InputStickAPI.git`

## Standard usage

ISManager:
- Create ISManager object with proper delegate
- Connect with InputStick Device

ISKeyboardHandler:
- Create ISKeyboardHandle object injecting the previously created ISManager
- Send text to InputStick using:

```- (void)sendText:(NSString *)text```
