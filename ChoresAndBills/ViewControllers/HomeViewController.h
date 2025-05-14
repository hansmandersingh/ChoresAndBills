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
#import "SettingsViewController.h"
@import FirebaseCore;
@import FirebaseAuth;
#import "Bill.h"
#import "Chore.h"

@interface HomeViewController : UIViewController

@property (nonatomic) GIDGoogleUser *user;
@property (nonatomic) FIRUser *FirebaseUserInfo;
@property (nonatomic) UserInfo *userData;
@property (nonatomic, strong) NSMutableArray<Bill *> *bills;
@property (nonatomic, strong) NSMutableArray<Chore *> *chores;
@property (nonatomic) UITextView *welcomeText;


@end

