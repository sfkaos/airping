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
#import "SXFlightSchedule.h"
#import "UIDetailViewController.h"
#import "SXFlightAwareClient.h"
#import "SXLocationClient.h"
#import "SXFlightManager.h"
#import "SXStartingViewController.h"


@interface SXTimerViewController ()
- (void)startTimer;
- (void)updateETATimer;
- (void)updateAlert;
- (NSArray*)searchForFlights;
- (void)getETATime;
@end

@implementation SXTimerViewController {
    CLLocationManager *locationManager;
}
@synthesize secondsA = _secondsA;
@synthesize pagingController = _pagingController;
@synthesize etaAlertView = _etaAlertView;
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
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    
    //Not actually used since simulator does not give real GPS data
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    //Instead will use AA HQ lat/long hardcoded
//    32.828665,-97.050347
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    //2013-03-10T17:00:00-05:00
    // Do any additional setup after loading the view from its nib.
    
    startA = TRUE;
    startETACounter = TRUE;
    
    [self startTimer];
    [self updateETATimer];
    [self updateTimer];
    
    self.pagingController = [[ATPagingViewController alloc] initWithNibName:@"ATPagingViewController" bundle:nil];
    
    ATGateViewController *gateController = [[ATGateViewController alloc] initWithNibName:@"ATGateViewController" bundle:nil];
    
    ATMapViewController *mapController = [[ATMapViewController alloc] initWithNibName:@"ATMapViewController" bundle:nil];
    
    [self.pagingController addChildViewController:gateController];
    [self.pagingController addChildViewController:mapController];
    
    [self addChildViewController:self.pagingController];
    CGRect pagingFrame = self.pagingController.view.frame;
    pagingFrame.origin.y = self.view.frame.size.height - 205.0f;
    [self.pagingController.view setFrame:pagingFrame];
    [self.view addSubview:self.pagingController.view];
    
    [self getData];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getData) userInfo:nil repeats:YES];
    
}

- (void)getETATime
{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"32.828665N,97.050347W",@"from", [[SXFlightManager sharedManager] departureAirport], @"to", nil];
    
    NSLog(@"parameters %@", parameters);
    
    
    [[SXLocationClient sharedClient] getPath:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = (NSDictionary*)JSON;
            NSLog(@"dict %@", dict);
            etaCounter = [[dict objectForKey:@"value"] intValue];
            NSLog(@"etaCounter is %d", etaCounter);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Uh oh" message:@"There was an error getting your location." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [errorAlertView show];
    }];

}

- (void)getData
{
    
//    {"boarding":"2013-03-10T19:00:00.000-05:00","changed":null,"flight_status":"ONTIME","flight_number":"427","origin_code":"AUS","destination_code":"LAX","terminal":null,"gate":"13","aa_advantage":"1234"}
    
    
    NSString *departureDate = [self.dateFormatter stringFromDate:[[SXFlightManager sharedManager] departureDate]];
    
    NSLog(@"sending departureDate as %@", departureDate);
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:[[SXFlightManager sharedManager] departureAirport],@"destination_code",[[SXFlightManager sharedManager] flightNumber], @"flight_number",departureDate, @"departure", nil];
    [[SXPHPClient sharedClient] getPath:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = (NSDictionary*)JSON;
        NSLog(@"%@", [dict objectForKey:@"aa_advantage"]);
        
        NSLog(@"whole dict %@", dict);
        NSLog(@"boarding time: %@", [dict objectForKey:@"boarding"]);
        NSString *boardingTime = [dict objectForKey:@"boarding"];
        NSString *departureTime = [dict objectForKey:@"departure"];
        NSLog(@"flight_number %@", [dict objectForKey:@"flight_number"]);
        NSLog(@"destination_code %@", [dict objectForKey:@"destination_code"]);
        NSLog(@"terminal %@", [dict objectForKey:@"terminal"]);
        NSLog(@"gate %@", [dict objectForKey:@"gate"]);
        NSDate *departureDate = [self.dateFormatter dateFromString:departureTime];
        
        [[SXFlightManager sharedManager] setDepartureDate:departureDate];
        [[SXFlightManager sharedManager] setFlightNumber:[dict objectForKey:@"flight_number"]];
        [[SXFlightManager sharedManager] setOriginCode:[dict objectForKey:@"origin_code"]];
        [[SXFlightManager sharedManager] setDestinationCode:[dict objectForKey:@"destination_code"]];
        [[SXFlightManager sharedManager] setTerminal:[dict objectForKey:@"terminal"]];
        [[SXFlightManager sharedManager] setGate:[dict objectForKey:@"gate"]];
        
        self.boardsInLabel.text = [NSString stringWithFormat:@"%@ boards in",[[SXFlightManager sharedManager] flightNumber]];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kdidUpdateFlightInfo object:nil];
        
//        NSDate *testDate = [NSDate date];
        NSLog(@"departure date %@", departureDate);
        
        departureCounter = [departureDate timeIntervalSinceDate:[NSDate date]];
        NSLog(@"counter %d", departureCounter);
        
        
        
//        [self updateTimer];
        //        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        //        for (NSDictionary *attributes in postsFromResponse) {
        //            BoardingInfo *boardingInfo = [[BoardingInfo alloc] initWithAttributes:attributes];
        //            [mutablePosts addObject:boardingInfo];
        //        }
        
        //        if (block) {
        //            block([NSArray arrayWithArray:mutablePosts], nil);
        //        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"WRONG: %@", [error localizedDescription]);
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
//    [self updateETATimer];
    
    CGFloat hours = floor(departureCounter/3600.0f);
    CGFloat totalminutes = floor(departureCounter/60.0f);
    CGFloat minutes = (int)floor(departureCounter/60.0f) % 60;
    CGFloat mseconds = round(departureCounter - (totalminutes * 60));
    
    
    if (hours > 0) {
        self.secondsA.text = [NSString stringWithFormat:@"%01d:%02d:%02d", (int)hours, (int)minutes, (int)mseconds];
    } else {
        self.secondsA.text = [NSString stringWithFormat:@"%02d:%02d", (int)minutes, (int)mseconds];
    }
    
    
    if (departureCounter < 0) // Once timer goes below 0, reset all variables.
    {
        self.secondsA.text = @"00:00";
//        [departureTimer invalidate];
        startA = TRUE;
//        departureCounter = 10;
        
    }
    
    [self updateAlert];
    
}

- (void)updateETATimer{ //Happens every time updateTimer is called. Should occur every second.
    [self getETATime];
    NSLog(@"etaCounter is %d", etaCounter);
    CGFloat hours = floor(etaCounter/3600.0f);
    CGFloat totalminutes = floor(etaCounter/60.0f);
    CGFloat minutes = (int)floor(etaCounter/60.0f) % 60;
    CGFloat mseconds = round(etaCounter - (totalminutes * 60));
    
    
    if (hours > 0) {
        self.etaTimer.text = [NSString stringWithFormat:@"%01d:%02d:%02d", (int)hours, (int)minutes, (int)mseconds];
    } else {
        self.etaTimer.text = [NSString stringWithFormat:@"%02d:%02d", (int)minutes, (int)mseconds];
    }
    
    
    if (etaCounter < 0) // Once timer goes below 0, reset all variables.
    {
        self.etaTimer.text = @"00:00";
        [departureTimer invalidate];
//        startA = TRUE;
        //        departureCounter = 10;
        
    }
    
}


-(void)startTimer {
    NSLog(@"timer");
    if(startA == TRUE) //Check that another instance is not already running.
    {
//        self.secondsA.text = @"10";
        startA = FALSE;
        departureTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        etaTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateETATimer) userInfo:nil repeats:YES];
    }
}

- (void)updateAlert
{
    NSLog(@"departureCounter %d", departureCounter);
    if ((departureCounter <= (15 * 60)) || (etaCounter >= departureCounter)) {
        [self.etaAlertView setBackgroundColor:[UIColor colorWithRed:218.0f/255.0f green:61.0f/255.0f blue:38.0f/255.0f alpha:1.0f]];
    } else {
        [self.etaAlertView setBackgroundColor:[UIColor colorWithRed:114.0f/255.0f green:193.0f/255.0f blue:176.0f/255.0f alpha:1.0f]];
    }
    
}

- (IBAction)settingsButtonSelected:(id)sender
{
    NSLog(@"settingsBUttonSelected");
    
    UIDetailViewController *detailController = [[UIDetailViewController alloc] initWithNibName:@"UIDetailViewController" bundle:nil];
    detailController.view.frame = CGRectMake(0, 20, 320, 460);
    [UIView transitionFromView:self.view toView:detailController.view duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
    }];
}

- (IBAction)backButtonSelected:(id)sender
{
    SXStartingViewController *startingController = [[SXStartingViewController alloc] initWithNibName:@"SXStartingViewController" bundle:nil];
    startingController.view.frame = CGRectMake(0, 20, 320, 460);
    
    [UIView transitionFromView:self.view toView:startingController.view duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

@end
