//
//  ChoresViewController.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-22.
//

#import "ChoresViewController.h"

@interface ChoresViewController ()

@end

@implementation ChoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAppearance];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Chores";
    UIAction *signOutAction = [UIAction actionWithTitle:@"Sign Out" image:[UIImage systemImageNamed:@"figure.run"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self signOut];
    }];
    NSArray<UIAction *> *actions = @[signOutAction];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis.circle"] menu:[UIMenu menuWithTitle:@"Menu" children:actions]];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
