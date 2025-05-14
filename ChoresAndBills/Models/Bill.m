//
//  Bill.m
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//

#import "Bill.h"
#import <FirebaseCore/FirebaseCore.h>

@implementation Bill

-(instancetype) initWithDictionary:(NSDictionary *)dict documentId:(NSString *)docId {
    self = [super init];
    if (self) {
        _billId = docId;
        _title = dict[@"title"];
        _amount = [dict[@"amount"] floatValue];
        _dueDate = [(FIRTimestamp *)dict[@"dueDate"] dateValue];
        _isPaid = [dict[@"isPaid"] boolValue];
    }
    return self;
}

@end
