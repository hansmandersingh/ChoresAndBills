//
//  HomeViewController.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-14.
//

#import "HomeViewController.h"

@interface HomeViewController () {
    UITabBarController *tabBarcontroller;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAppearance];
    self.navigationController.navigationBar.prefersLargeTitles = YES;

    
    self.title = @"Welcome";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(signOut)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self initializeTabBarController];
    
    // Do any additional setup after loading the view.
}

-(void)initializeTabBarController {
    tabBarcontroller = [[UITabBarController alloc] init];
    UINavigationController *choresController = [[UINavigationController alloc] initWithRootViewController:[ChoresViewController new]];
    choresController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chores" image:[UIImage systemImageNamed:@"figure.run"] tag:0];
    UINavigationController *billsController = [[UINavigationController alloc] initWithRootViewController:[BillsViewController new]];
    billsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Bills" image:[UIImage systemImageNamed:@"book.pages"] tag:0];
    
    NSArray *controller = [NSArray arrayWithObjects:choresController,billsController, nil];
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
