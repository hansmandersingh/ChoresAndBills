//
//  Chore.m
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//
#import "Chore.h"
#import <FirebaseCore/FirebaseCore.h>

@implementation Chore

- (instancetype)initWithDictionary:(NSDictionary *)dict documentId:(NSString *)docId {
    self = [super init];
    if (self) {
        _choreId = docId;
        _title = dict[@"title"];
        _details = dict[@"details"];
        _dueDate = [(FIRTimestamp *)dict[@"dueDate"] dateValue];
        _isCompleted = [dict[@"isCompleted"] boolValue];
    }
    return self;
}

@end
