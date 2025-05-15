//
//  SceneDelegate.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-08.
//

#import "SceneDelegate.h"
#define DATABASE_INIT_NAME @"users"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    [GIDSignIn.sharedInstance restorePreviousSignInWithCompletion:^(GIDGoogleUser * _Nullable user,
                                                                      NSError * _Nullable error) {
        if (error) {
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
            [navController setModalPresentationStyle:UIModalPresentationFullScreen];
            self.window.rootViewController = navController;
            //[self.window.rootViewController.navigationController setViewControllers:@[[LoginViewController new]] animated:YES];
        } else {
            if ([[FIRAuth auth] currentUser]) {
                FIRUser *authResult = [[FIRAuth auth] currentUser];
                [self fetchAllData:authResult.email];
            }
        }
      }];
    
    [self.window makeKeyAndVisible];
}

-(void)fetchAllData:(NSString *)uid {
    FIRFirestore *db = [FIRFirestore firestore];
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
            [self postDataFetchingSteps:loggedInUser bills:bills chores:chores];
        });
}

-(void)postDataFetchingSteps: (UserInfo *)loggedInUser bills:(NSMutableArray<Bill *>*)bills chores:(NSMutableArray<Chore *>*)chores {
    if (loggedInUser) {
        HomeViewController *newViewController = [HomeViewController new];
        [newViewController setModalPresentationStyle:UIModalPresentationFullScreen];
        newViewController.userData = loggedInUser;
        newViewController.chores = chores;
        newViewController.bills = bills;
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:newViewController];
        [self.window makeKeyAndVisible];
    } else {
        LoginViewController *newViewController = [LoginViewController new];
        [newViewController setModalPresentationStyle:UIModalPresentationFullScreen];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:newViewController];
        [self.window makeKeyAndVisible];
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  BOOL handled;

  handled = [GIDSignIn.sharedInstance handleURL:url];
  if (handled) {
    return YES;
  }

  // Handle other custom URL types.

  // If not handled by this app, return NO.
  return NO;
}


@end
