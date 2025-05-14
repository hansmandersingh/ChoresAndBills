//
//  Chore.h
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-14.
//

#import <Foundation/Foundation.h>

@interface Chore: NSObject

@property (nonatomic, strong) NSString *choreId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *details;
@property (nonatomic,strong) NSDate *dueDate;
@property (nonatomic, assign) BOOL isCompleted;

-(instancetype)initWithId:(NSString *)choreId title:(NSString *)title details:(NSString *)details dueDate:(NSDate *)dueDate;

@end
