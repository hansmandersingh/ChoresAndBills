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
#import "FIRUser.h"
#import "UserInfo.h"
#import "ChoresViewController.h"
#import "BillsViewController.h"
#import "SettingsViewController.h"
@import FirebaseCore;
@import FirebaseAuth;

@interface HomeViewController : UIViewController

@property (nonatomic) GIDGoogleUser *user;
@property (nonatomic) FIRUser *FirebaseUserInfo;
@property (nonatomic) UserInfo *userData;
@property (nonatomic) UITextView *welcomeText;

-(void)signOut;

@end

