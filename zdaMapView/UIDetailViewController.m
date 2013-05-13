//
//  UIDetailViewController.m
//  AirPing
//
//  Created by Winfred Raguini on 3/10/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "UIDetailViewController.h"
#import "SXTimerViewController.h"
#import "SXFlightAwareClient.h"
#import "SXFlightSchedule.h"
#import "SXFlightManager.h"

#define kUserName @"winraguini"
#define kAPIKey @"40a82412fd918acf488e7a7c2a3f47e875103b1c"

@interface UIDetailViewController ()
@property (nonatomic, strong) NSArray *altFlightsArray;
@property (nonatomic, strong) NSMutableArray *mutableFlightArray;
@end

@implementation UIDetailViewController

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
    self.mutableFlightArray = [[NSMutableArray alloc] init];
    [self.activityView startAnimating];
    // Do any additional setup after loading the view from its nib.
    [[SXFlightAwareClient sharedClient] setUsername:kUserName andPassword:kAPIKey];
    [[SXFlightAwareClient sharedClient] setDelegate:self];
    
//    [self findAlternateFlights];
    
//    [[SXFlightAwareClient sharedClient] searchForFlightsWithParameters:[NSDictionary dictionary]];
    
    self.tableView.rowHeight = 72.0f;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:134.0f/255.0f blue:125.0f/255.0f alpha:1.0f]];
    [self.tableView setScrollEnabled:NO];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsButtonSelected:(id)sender
{
    SXTimerViewController *timerController = [[SXTimerViewController alloc] initWithNibName:@"SXTimerViewController" bundle:nil];
    NSLog(@"settingsBUttonSelected");
    
    timerController.view.frame = CGRectMake(0, 20, 320, 460);
    [UIView transitionFromView:self.view toView:timerController.view duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

- (void)findAlternateFlights
{
    int nowTime = (int)[[NSDate date] timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    [dateComponents setDay:[dateComponents day] + 7];
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    int endTime = (int)[endDate timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInt:nowTime], @"startDate", [NSNumber numberWithInt:endTime], @"endDate", [[SXFlightManager sharedManager] originCode], @"origin", @"AA", @"airline", @"3", @"howMany", nil];
//    __block NSMutableArray *mutableFlightArray;
    [[SXFlightAwareClient sharedClient] getPath:@"AirlineFlightSchedules" parameters:dict success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = (NSDictionary*)JSON;
        NSArray *flightsArray = [[dict objectForKey:@"AirlineFlightSchedulesResult"] objectForKey:@"data"];
//        mutableFlightArray = [[NSMutableArray alloc] init];
        for (NSDictionary *flightDict in flightsArray) {
            SXFlightSchedule *flightSchedule = [[SXFlightSchedule alloc] initWithAttributes:flightDict];
            [self.mutableFlightArray addObject:flightSchedule];
        }
        [self.activityView stopAnimating];
        self.altFlightsArray = self.mutableFlightArray;
        SXFlightSchedule *flightSchedule = [self.altFlightsArray objectAtIndex:0];
        
        self.fromToLabel.text = [NSString stringWithFormat:@"%@ - %@",[[SXFlightManager sharedManager] originCode], [[SXFlightManager sharedManager] destinationCode]];
        
           NSLog(@"actualIdent is %@", flightSchedule.actualIdent);
         [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        if (block) {
        //            block([NSArray array], error);
        //        }
        NSLog(@"Error");
    }];
}

//- (void)flightHTTPClient:(SXFlightAwareClient*)client didFindFlights:(NSArray*)flightsArray
//{
//    [self.activityView stopAnimating];
//    altFlightsArray = flightsArray;
//    NSLog(@"got these flights %@", altFlightsArray);
//    NSLog(@"here's one %@", [altFlightsArray objectAtIndex:0]);
//    SXFlightSchedule *flightSchedule = [altFlightsArray objectAtIndex:0];
//    NSLog(@"actualIdent is %@", flightSchedule.actualIdent);
//    [self.tableView reloadData];
//}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.altFlightsArray count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //"actual_ident" = AAL2278;
    //aircrafttype = B738;
    //arrivaltime = 1366824300;
    //departuretime = 1366812000;
    //destination = KDFW;
    //ident = QLK3175;
    //"meal_service" = "First: Meal / Economy: Food for sale";
    //origin = KSFO;
    //"seats_cabin_business" = 0;
    //"seats_cabin_coach" = 132;
    //"seats_cabin_first" = 16;
//    @property (readonly) NSString *actualIdent;
//    @property (readonly) NSString *aircraftType;
//    @property (readonly) NSString *arrivalTime;
//    @property (readonly) NSString *departureTime;
//    @property (readonly) NSString *destination;
//    @property (readonly) NSString *ident;
//    @property (readonly) NSString *mealService;
//    @property (readonly) NSString *origin;
//    @property (readonly) NSString *seatsCabinBusiness;
//    @property (readonly) NSString *seatsCabinCoach;
//    @property (readonly) NSString *seatsCabinFirst;
    
    SXFlightSchedule *flightSchedule = [self.altFlightsArray objectAtIndex:indexPath.row];
    
    UILabel *flightNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,20.0f, 280.0f, 45.0f)];
    [flightNumberLabel setTextColor:[UIColor colorWithRed:253.0f/255.0f green:243.0f/255.0f blue:197.0f/255.0f alpha:1.0f]];
    [flightNumberLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35.0f]];
    [flightNumberLabel setTextAlignment:UITextAlignmentLeft];
    [flightNumberLabel setBackgroundColor:[UIColor clearColor]];
    flightNumberLabel.text = [NSString stringWithFormat:@"Flight %@",flightSchedule.actualIdent];
    [cell.contentView addSubview:flightNumberLabel];
    // Configure the cell...
//    cell.textLabel.text = [self.countryArray objectAtIndex:indexPath.row];
    
    int departureTimeInSeconds = [flightSchedule.departureTime intValue];
    
    NSDate *departureTime = [NSDate dateWithTimeIntervalSince1970:departureTimeInSeconds];
    
    NSString *theTime = [dateFormatter stringFromDate:departureTime];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, 200.0f, 20.0f)];
    [timeLabel setTextColor:[UIColor colorWithRed:62.0f/255.0f green:63.0f/255.0f blue:55.0f/255.0f alpha:1.0f]];
    [timeLabel setTextAlignment:UITextAlignmentLeft];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    timeLabel.text = theTime;
    [cell.contentView addSubview:timeLabel];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
