//
//  Bill.h
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//
#import <Foundation/Foundation.h>

@interface Bill : NSObject

@property (nonatomic, strong) NSString *billId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float amount;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic,assign) BOOL isPaid;
@property (nonatomic, strong) NSArray<NSString *> *sharedWith;

-(instancetype) initWithDictionary:(NSDictionary *)dict documentId:(NSString *)docId;

@end
