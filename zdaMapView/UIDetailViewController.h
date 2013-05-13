//
//  UIDetailViewController.h
//  AirPing
//
//  Created by Winfred Raguini on 3/10/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *fromToLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityView;
- (IBAction)settingsButtonSelected:(id)sender;
@end
