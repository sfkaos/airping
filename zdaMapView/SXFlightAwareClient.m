//
//  SXFlightAwareClient.m
//  AirPing
//
//  Created by Winfred Raguini on 4/24/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "SXFlightAwareClient.h"
#import "AFJSONRequestOperation.h"
#import "SXFlightSchedule.h"

static NSString *kSXFlightAwareAPIBaseURLString = @"http://flightxml.flightaware.com/json/FlightXML2/";

@implementation SXFlightAwareClient
+ (SXFlightAwareClient *)sharedClient
{
    static SXFlightAwareClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SXFlightAwareClient alloc] initWithBaseURL:[NSURL URLWithString:kSXFlightAwareAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (void)setUsername:(NSString *)username andPassword:(NSString *)password
{
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:username password:password];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

- (void)searchForFlightsWithParameters:(NSDictionary*)param
{
    int nowTime = (int)[[NSDate date] timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    [dateComponents setDay:[dateComponents day] + 7];
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    int endTime = (int)[endDate timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInt:nowTime], @"startDate", [NSNumber numberWithInt:endTime], @"endDate", @"SFO", @"origin", @"AA", @"airline", @"3", @"howMany", nil];
    __block NSMutableArray *mutableFlightArray;
    [[SXFlightAwareClient sharedClient] getPath:@"AirlineFlightSchedules" parameters:dict success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = (NSDictionary*)JSON;
        NSArray *flightsArray = [[dict objectForKey:@"AirlineFlightSchedulesResult"] objectForKey:@"data"];
        mutableFlightArray = [[NSMutableArray alloc] init];
        for (NSDictionary *flightDict in flightsArray) {
            SXFlightSchedule *flightSchedule = [[SXFlightSchedule alloc] initWithAttributes:flightDict];
            [mutableFlightArray addObject:flightSchedule];
        }
        NSLog(@"flight %@", [flightsArray objectAtIndex:0]);
        if ([self.delegate respondsToSelector:@selector(flightHTTPClient:didFindFlights:)]) {
            [self.delegate flightHTTPClient:self didFindFlights:mutableFlightArray];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        if (block) {
        //            block([NSArray array], error);
        //        }
        NSLog(@"Error");
    }];
}

@end
