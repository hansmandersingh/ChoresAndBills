//
//  UIViewController+SharableMethods.h
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-04-30.
//

#import <UIKit/UIKit.h>
#import "GIDGoogleUser.h"
#import "GIDSignIn.h"
#import "LoginViewController.h"
#import "FIRUser.h"
@import FirebaseCore;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SharableMethods)

-(void)signOut;
-(void)updateAppearance;

@end

NS_ASSUME_NONNULL_END
