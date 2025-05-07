//
//  UserInfo.h
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-21.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSArray<NSString *> *chores;
@property (nonatomic) NSArray<NSString *> *Bills;

@end
