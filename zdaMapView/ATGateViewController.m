//
//  ATGateViewController.m
//  zdaMapView
//
//  Created by Winfred Raguini on 3/10/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import "ATGateViewController.h"
#import "SXFlightManager.h"

@interface ATGateViewController ()

@end

@implementation ATGateViewController
@synthesize gateLabel = _gateLabel;
@synthesize terminalLabel = _terminalLabel;


NSDateFormatter *dateFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateFlightInfo:) name:kdidUpdateFlightInfo object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didUpdateFlightInfo:(NSNotification*)note
{
    if ([self.gateLabel.text length] == 0) {
        self.gateLabel.text = [NSString stringWithFormat:@"%@",[[SXFlightManager sharedManager] gate]];
        self.terminalLabel.text = [NSString stringWithFormat:@"Terminal %@",[[SXFlightManager sharedManager] terminal]];
        self.flightLabel.text = [[SXFlightManager sharedManager] flightNumber];
    }
   NSLog(@"departure date: %@",[[SXFlightManager sharedManager] departureDate]);
    
    self.timeLabel.text = [dateFormatter stringFromDate:[[SXFlightManager sharedManager] departureDate]];
    
}

@end
