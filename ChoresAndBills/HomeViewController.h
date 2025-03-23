//
//  HomeViewController.h
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-14.
//

#import <UIKit/UIKit.h>
#import "GIDGoogleUser.h"
#import "GIDSignIn.h"
#import "LoginViewController.h"
#import "FIRUserInfo.h"
#import "UserInfo.h"
@import FirebaseCore;
@import FirebaseAuth;

@interface HomeViewController : UIViewController

@property (nonatomic) GIDGoogleUser *user;
@property (nonatomic) FIRUser *FirebaseUserInfo;
@property (nonatomic) UserInfo *userData;

@end

