//
//  UIViewController+SharableMethods.m
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-04-30.
//

#import "UIViewController+SharableMethods.h"

@implementation UIViewController (SharableMethods)

-(void)signOut {
    [GIDSignIn.sharedInstance signOut];
    NSError *signOutError;
    [[FIRAuth auth]signOut:&signOutError];
    UINavigationController *fullScreenLoginViewController = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
    [fullScreenLoginViewController setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [self presentViewController:fullScreenLoginViewController animated:YES completion:nil];
}


- (void)updateAppearance {
    if (@available(iOS 13.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor blackColor];
        } else {
            self.view.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
