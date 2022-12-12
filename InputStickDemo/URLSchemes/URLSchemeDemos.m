/*
* InputStickDemo-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import "URLSchemeDemos.h"

NSString *const USBRemoteAppStoreURL = @"itms://itunes.apple.com/us/app/usb-remote/id1135444072?mt=8";



@interface URLSchemeDemos ()

@end


@implementation URLSchemeDemos

/*
Important: you must add:
<key>LSApplicationQueriesSchemes</key>
<array>
    ..........
    <string>usbremote</string>
</array>
to Info.plist file

 Requires USB Remote v1.53 or higher
*/
+ (BOOL)shareToUSBRemote:(UIViewController *)viewController {
    NSString *text = @"USB Remote URLScheme test (`~\\|/@:$#^&*!,.'\")";
    
    NSMutableString *tmp = [NSMutableString stringWithString:@"usbremote://?text="];
    [tmp appendString:[text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]];
    //expected tmp value: usbremote://?text=USB%20Remote%20URLScheme%20test%20%28%60%7E%5C%7C%2F%40%3A%24%23%5E%26%2A%21%2C%2E%27%22%29
    NSURL *url = [NSURL URLWithString:tmp];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url
                                           options:@{}
                                 completionHandler:nil];
        return TRUE;
    } else {
        //USB Remote is not installed, show download dialog
        if (viewController != nil) {
            UIAlertController *alertController = [URLSchemeDemos downloadUSBRemoteAlertDialog];
            [viewController presentViewController:alertController animated:YES completion:nil];
        }
        return FALSE;
    }
}

+ (UIAlertController *)downloadUSBRemoteAlertDialog {
    NSString *title = @"Download USB Remote?";
    NSString *message = @"USB Remote is not installed on this device. Download from App Store?";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:@"Download"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:USBRemoteAppStoreURL]
                                                                                                   options:@{}
                                                                                         completionHandler:nil];
                                                            }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alertController addAction:downloadAction];
    [alertController addAction:cancelAction];
    return alertController;
}


@end
