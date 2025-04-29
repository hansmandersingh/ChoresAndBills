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
                FIRFirestore *db = [FIRFirestore firestore];
                
                [[[db collectionWithPath:DATABASE_INIT_NAME] documentWithPath:authResult.email] getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
                      if (error != nil) {
                        NSLog(@"Error getting document: %@", error);
                      } else if (snapshot.exists) {
                          NSDictionary *data = snapshot.data;
                          UserInfo *userData = [[UserInfo alloc] init];
                          userData.firstName = [data valueForKey:@"first name"];
                          userData.lastName = [data valueForKey:@"last name"];
                          userData.chores = [data valueForKey:@"chores"];
                          userData.Bills = [data valueForKey:@"Bills"];
                          NSLog(@"%@", userData.chores);
                          
                          NSLog(@"results %@", authResult.displayName);
                          HomeViewController *newViewController = [HomeViewController new];
                          [newViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                          newViewController.user = user;
                          newViewController.userData = userData;
                          self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:newViewController];
                          [self.window makeKeyAndVisible];
                      } else {
                          NSLog(@"Document does not exist scene delegate");
                          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No data here" message:@"Fix this !!!" preferredStyle:UIAlertControllerStyleAlert];
                          UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                              [GIDSignIn.sharedInstance signOut];
                              NSError *signOutError;
                              [[FIRAuth auth]signOut:&signOutError];
                              UINavigationController *navController = [[UINavigationController alloc]init];
                              [navController setViewControllers:@[[LoginViewController new]] animated:YES];
                              self.window.rootViewController = navController;
                              [self.window makeKeyAndVisible];
                          }];
                          [alertController addAction:okButton];
                          self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
                          [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
                          [self.window makeKeyAndVisible];
                          
                      }
                    }];
            }
        }
      }];
    
    [self.window makeKeyAndVisible];
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
