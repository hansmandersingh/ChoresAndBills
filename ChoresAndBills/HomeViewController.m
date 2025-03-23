//
//  HomeViewController.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-14.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAppearance];
    self.navigationController.navigationBar.prefersLargeTitles = YES;

    
    self.title = @"Welcome";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(signOut)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // Do any additional setup after loading the view.
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];

    if (@available(iOS 13.0, *)) {
        if (@available(iOS 13.0, *)) {
            if (previousTraitCollection &&
                previousTraitCollection.userInterfaceStyle != self.traitCollection.userInterfaceStyle) {
                [self updateAppearance];
            }
        }
    }
}

-(void)signOut {
    [GIDSignIn.sharedInstance signOut];
    NSError *signOutError;
    [[FIRAuth auth]signOut:&signOutError];
    [self.navigationController setViewControllers:@[[LoginViewController new]] animated:YES];
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
