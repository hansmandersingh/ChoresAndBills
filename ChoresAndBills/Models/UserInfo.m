//
//  UserInfo.m
//  ChoresAndBills
//
//  Created by Hansmander Singh on 2025-03-21.
//

#import "UserInfo.h"

@implementation UserInfo

-(instancetype) initWithDictionary: (NSDictionary *)dict documentId:(NSString *)docId {
    self = [super init];
    if (self) {
        _email = dict[@"email"];
        _firstName = dict[@"first name"];
        _lastName = dict[@"last name"];
    }
    return self;
}

@end
