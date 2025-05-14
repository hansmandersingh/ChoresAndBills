//
//  Chore.m
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//
#import "Chore.h"

@implementation Chore

- (instancetype)initWithId:(NSString *)choreId title:(NSString *)title details:(NSString *)details dueDate:(NSDate *)dueDate {
    self = [super init];
    if (self) {
        self.choreId = choreId;
        _title = title;
        _details = details;
        _dueDate = dueDate;
    }
    return self;
}

@end
