//
//  SXTimerViewController.m
//  zdaMapView
//
//  Created by Winfred Raguini on 3/9/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import "SXTimerViewController.h"
#import "ATGateViewController.h"
#import "ATMapViewController.h"
#import "SXPHPClient.h"
#import "BoardingInfoManager.h"

@interface SXTimerViewController ()
- (void)startTimer;
@end

@implementation SXTimerViewController
@synthesize secondsA = _secondsA;
@synthesize pagingController = _pagingController;
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
    counterA = 86400;
    startA = TRUE;
    [self startTimer];
    
    self.pagingController = [[ATPagingViewController alloc] initWithNibName:@"ATPagingViewController" bundle:nil];
    
    ATGateViewController *gateController = [[ATGateViewController alloc] initWithNibName:@"ATGateViewController" bundle:nil];
    
    ATMapViewController *mapController = [[ATMapViewController alloc] initWithNibName:@"ATMapViewController" bundle:nil];
    
    [self.pagingController addChildViewController:gateController];
    [self.pagingController addChildViewController:mapController];
    
    [self addChildViewController:self.pagingController];
    CGRect pagingFrame = self.pagingController.view.frame;
    pagingFrame.origin.y = 300.0f;
    [self.pagingController.view setFrame:pagingFrame];
    [self.view addSubview:self.pagingController.view];
    
    
    [[SXPHPClient sharedClient] getPath:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = (NSDictionary*)JSON;
        NSLog(@"%@", [dict objectForKey:@"aa_advantage"]);
        NSLog(@"whole dict %@", dict);
//        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
//        for (NSDictionary *attributes in postsFromResponse) {
//            BoardingInfo *boardingInfo = [[BoardingInfo alloc] initWithAttributes:attributes];
//            [mutablePosts addObject:boardingInfo];
//        }
        
//        if (block) {
//            block([NSArray arrayWithArray:mutablePosts], nil);
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (block) {
//            block([NSArray array], error);
//        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer{ //Happens every time updateTimer is called. Should occur every second.
    
    counterA -= 1;
    
    CGFloat hours = floor(counterA/3600.0f);
    CGFloat totalminutes = floor(counterA/60.0f);
    CGFloat minutes = (int)floor(counterA/60.0f) % 60;
    CGFloat mseconds = round(counterA - (totalminutes * 60));
    
    
    if (hours > 0) {
        self.secondsA.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)hours, (int)minutes, (int)mseconds];
    } else {
        self.secondsA.text = [NSString stringWithFormat:@"%02d:%02d", (int)minutes, (int)mseconds];
    }
    
    
    if (counterA < 0) // Once timer goes below 0, reset all variables.
    {
        
        self.secondsA.text = @"";
        
        [timerA invalidate];
        startA = TRUE;
        counterA = 10;
        
    }
    
}

-(void)startTimer {
    
    if(startA == TRUE) //Check that another instance is not already running.
    {
//        self.secondsA.text = @"10";
        startA = FALSE;
        timerA = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
}


@end
