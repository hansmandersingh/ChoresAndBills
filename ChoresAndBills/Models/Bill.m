//
//  Bill.m
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//

#import "Bill.h"

@implementation Bill

- (instancetype)initWithId:(NSString *)billId title:(NSString *)title amount:(float)amount dueDate:(NSDate *)dueDate {
    self = [super init];
    if (self) {
        _billId = billId;
        _title = title;
        _amount = amount;
        _dueDate = dueDate;
        _isPaid = NO;
    }
    return self;
}

@end
