//
//  LoginViewController.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-08.
//

#import "LoginViewController.h"
#define DATABASE_INIT_NAME @"users"

@interface LoginViewController ()

@property (nonatomic) GIDSignInButton *signInButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Log In";
    [self updateAppearance];
    
    _signInButton = [GIDSignInButton new];
    [_signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    _signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_signInButton];
    
    [_signInButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [_signInButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

-(void)signIn {
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:[FIRApp defaultApp].options.clientID];
    [GIDSignIn.sharedInstance setConfiguration:config];

    __weak __auto_type weakSelf = self;
    [GIDSignIn.sharedInstance signInWithPresentingViewController:self
          completion:^(GIDSignInResult * _Nullable result, NSError * _Nullable error) {
      __auto_type strongSelf = weakSelf;
      if (strongSelf == nil) { return; }

      if (error == nil) {
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:result.user.idToken.tokenString
                                         accessToken:result.user.accessToken.tokenString];
          [[FIRAuth auth] signInWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
              if (authResult) {
                      FIRFirestore *db = [FIRFirestore firestore];
                  
                  [[[db collectionWithPath:DATABASE_INIT_NAME] documentWithPath:authResult.user.email] getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
                        if (error != nil) {
                          NSLog(@"Error getting document: %@", error);
                        } else if (snapshot.exists) {
                            NSDictionary *data = snapshot.data;
                            UserInfo *userData = [[UserInfo alloc] init];
                            userData.firstName = [data valueForKey:@"first name"];
                            userData.lastName = [data valueForKey:@"last name"];
                            userData.chores = [data valueForKey:@"chores"];
                            userData.Bills = [data valueForKey:@"Bills"];
                            NSLog(@"%@", userData.Bills);
                            
                            NSLog(@"results %@", authResult.user.displayName);
                            HomeViewController *newViewController = [HomeViewController new];
                            [newViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                            newViewController.user = result.user;
                            newViewController.userData = userData;
                            [self.navigationController setViewControllers:@[newViewController] animated:YES];
                        } else {
                          NSLog(@"Document does not exist");
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No data here" message:@"Fix this !!!" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [GIDSignIn.sharedInstance signOut];
                                NSError *signOutError;
                                [[FIRAuth auth]signOut:&signOutError];
                                [self.navigationController setViewControllers:@[[LoginViewController new]] animated:YES];
                            }];
                            [alertController addAction:okButton];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                      }];
              } else {
                  NSLog(@"error %@", error);
              }
          }];
      } else {
        // ...
      }
    }];
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
