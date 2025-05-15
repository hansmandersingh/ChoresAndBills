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

              if (error) {
                  NSLog(@"Firebase Sign-In Error: %@", error.localizedDescription);
                  return;
              }
              [self fetchAllData:authResult];
          }];
      } else {
        // ...
      }
    }];
}

-(void)fetchAllData:(FIRAuthDataResult *)authResult {
    FIRFirestore *db = [FIRFirestore firestore];
    NSString *uid = authResult.user.email;
    dispatch_group_t group = dispatch_group_create();
    
    __block UserInfo *loggedInUser;
    __block NSMutableArray<Bill *> *bills = [NSMutableArray array];
    __block NSMutableArray<Chore *> *chores = [NSMutableArray array];
    __block NSError *fetchError = nil;
    
    //Fetch users
    dispatch_group_enter(group);
    [[[db collectionWithPath:@"users"] documentWithPath:uid] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
            if (snapshot.exists) {
                loggedInUser = [[UserInfo alloc] initWithDictionary:snapshot.data documentId:snapshot.documentID];
            }
            dispatch_group_leave(group);
    }];
    
    //fetch Bills
    dispatch_group_enter(group);
    [[[db collectionWithPath:@"bills"] queryWhereField:@"sharedWith" arrayContains:uid] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error) {
            fetchError = error;
        } else {
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                Bill *bill = [[Bill alloc] initWithDictionary:doc.data documentId:doc.documentID];
                [bills addObject:bill];
            }
        }
        dispatch_group_leave(group);
    }];
    
    //fetch chores
    
    dispatch_group_enter(group);
    [[[db collectionWithPath:@"chores"]queryWhereField:@"sharedWith" arrayContains:uid] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            if (error) {
                fetchError = error;
            } else {
                for (FIRDocumentSnapshot *doc in snapshot.documents) {
                    Chore *chore = [[Chore alloc] initWithDictionary:doc.data documentId:doc.documentID];
                    [chores addObject:chore];
                }
            }
            dispatch_group_leave(group);
        }];
    // Notify when all done
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self postDataFetchingSteps:loggedInUser bills:bills chores:chores authResults:authResult];
        });
}

-(void)postDataFetchingSteps: (UserInfo *)loggedInUser bills:(NSMutableArray<Bill *>*)bills chores:(NSMutableArray<Chore *>*)chores authResults:(FIRAuthDataResult *)authResult {
    UserInfo *refactoredLoggedInUser = [[UserInfo alloc] init];
    
    if (!loggedInUser) {
        FIRFirestore *db = [FIRFirestore  firestore];
        [[[db collectionWithPath:@"users"] documentWithPath:authResult.user.email] setData:@{
                    @"email": authResult.user.email,
                    @"first name": authResult.user.displayName,
                    @"last name": authResult.user.displayName
                } completion:^(NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"Error writing document: %@ ", error);
                    } else {
                        NSLog(@"Document successfully written!");
                    }
        }];
        refactoredLoggedInUser.email = authResult.user.email;
        refactoredLoggedInUser.firstName = authResult.user.displayName;
        refactoredLoggedInUser.lastName = authResult.user.displayName;
    } else {
        refactoredLoggedInUser.email = loggedInUser.email;
        refactoredLoggedInUser.firstName = loggedInUser.firstName;
        refactoredLoggedInUser.lastName = loggedInUser.lastName;
    }
    
    
    HomeViewController *newViewController = [HomeViewController new];
    [newViewController setModalPresentationStyle:UIModalPresentationFullScreen];
    newViewController.userData = refactoredLoggedInUser;
    newViewController.chores = chores;
    newViewController.bills = bills;
    [self.navigationController setViewControllers:@[newViewController] animated:YES];
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
