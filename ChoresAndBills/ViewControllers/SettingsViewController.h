//
//  SettingsViewController.h
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-04-29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tableContent;

@end

NS_ASSUME_NONNULL_END
