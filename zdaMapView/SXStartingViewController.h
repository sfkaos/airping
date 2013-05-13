//
//  SXStartingViewController.h
//  AirPing
//
//  Created by Winfred Raguini on 5/12/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXStartingViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIView *buttonView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *departureDateField;
@property (nonatomic, strong) IBOutlet UITextField *departureAirportField;
@property (nonatomic, strong) IBOutlet UITextField *flightNumberField;
- (IBAction)endEdittingButtonSelected:(id)sender;
- (IBAction)beginButtonSelected:(id)sender;
@end
