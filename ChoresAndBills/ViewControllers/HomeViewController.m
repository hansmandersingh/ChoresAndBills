//
//  HomeViewController.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-14.
//

#import "HomeViewController.h"
#import "ChoresAndBills-Swift.h"

@interface HomeViewController () {
    UITabBarController *tabBarcontroller;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAppearance];
    self.navigationController.navigationBarHidden = YES;
    [self initializeTabBarController];
    
    // Do any additional setup after loading the view.
}

-(void)initializeTabBarController {
    tabBarcontroller = [[UITabBarController alloc] init];
    UINavigationController *choresController = [[UINavigationController alloc] initWithRootViewController:[ChoresViewControllerSwift create:self.user :self.userData]];
    [choresController setNavigationBarHidden:YES];
    choresController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chores" image:[UIImage systemImageNamed:@"figure.run"] tag:0];
    UINavigationController *billsController = [[UINavigationController alloc] initWithRootViewController:[BillsViewControllerSwift create:self.user :self.userData]];
    [billsController setNavigationBarHidden:YES];
    billsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Bills" image:[UIImage systemImageNamed:@"book.pages"] tag:0];
    UINavigationController *settingsController = [[UINavigationController alloc] initWithRootViewController:[SettingsViewControllerSwift create]];
    [settingsController setNavigationBarHidden:YES];
    settingsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage systemImageNamed:@"gear"] tag:0];
    
    NSArray *controller = [NSArray arrayWithObjects:choresController,billsController,settingsController, nil];
    [tabBarcontroller setViewControllers:controller animated:YES];
    
    [self addChildViewController:tabBarcontroller];
    [self.view addSubview:[tabBarcontroller view]];
    [self.tabBarController didMoveToParentViewController:self];
    
    
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
