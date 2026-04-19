#import <UIKit/UIKit.h>

__attribute__((visibility("default")))
extern "C" void ios_show_alert(const char* title, const char* message)
{
    NSString *t = [NSString stringWithUTF8String:title];
    NSString *m = [NSString stringWithUTF8String:message];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:t
                                            message:m
                                     preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:ok];

        UIViewController *root =
        [UIApplication sharedApplication].keyWindow.rootViewController;

        [root presentViewController:alert animated:YES completion:nil];
    });
}
