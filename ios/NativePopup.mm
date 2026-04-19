#import <UIKit/UIKit.h>

extern "C" void ios_show_alert(const char* title, const char* message)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root =
        [UIApplication sharedApplication].keyWindow.rootViewController;

        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:[NSString stringWithUTF8String:title]
                                            message:[NSString stringWithUTF8String:message]
                                     preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:ok];

        [root presentViewController:alert animated:YES completion:nil];
    });
}
