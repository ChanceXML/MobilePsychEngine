#import <UIKit/UIKit.h>
#include "NativePopup.h"

extern "C" void ios_show_alert(const char* title, const char* message)
{
    NSString *t = [NSString stringWithUTF8String:(title ? title : "")];
    NSString *m = [NSString stringWithUTF8String:(message ? message : "")];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root = UIApplication.sharedApplication.keyWindow.rootViewController;

        if (root == nil && UIApplication.sharedApplication.windows.count > 0)
        {
            root = UIApplication.sharedApplication.windows.firstObject.rootViewController;
        }

        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:t
                                            message:m
                                     preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:ok];

        if (root != nil)
            [root presentViewController:alert animated:YES completion:nil];
    });
}
