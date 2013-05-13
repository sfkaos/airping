//
//  BoardingInfo.m
//  zdaMapView
//
//  Created by Winfred Raguini on 3/10/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import "SXFlightSchedule.h"

@implementation SXFlightSchedule
- (id)initWithAttributes:(NSDictionary *)attributes
{
    NSLog(@"attribs are %@", attributes);
//    "actual_ident" = AAL2278;
//    aircrafttype = B738;
//    arrivaltime = 1366824300;
//    departuretime = 1366812000;
//    destination = KDFW;
//    ident = QLK3175;
//    "meal_service" = "First: Meal / Economy: Food for sale";
//    origin = KSFO;
//    "seats_cabin_business" = 0;
//    "seats_cabin_coach" = 132;
//    "seats_cabin_first" = 16;
    if (self = [super init]) {
        _actualIdent = [attributes objectForKey:@"ident"];
        _aircraftType = [attributes objectForKey:@"aircrafttype"];
        _arrivalTime = [attributes objectForKey:@"arrivaltime"];
        _departureTime = [attributes objectForKey:@"departuretime"];
        _destination = [attributes objectForKey:@"destination"];
        _ident = [attributes objectForKey:@"ident"];
        _mealService = [attributes objectForKey:@"meal_service"];
        _origin = [attributes objectForKey:@"origin"];
        _seatsCabinBusiness = [attributes objectForKey:@"seats_cabin_business"];
        _seatsCabinCoach = [attributes objectForKey:@"seats_cabin_coach"];
        _seatsCabinFirst = [attributes objectForKey:@"seats_cabin_first"];
    }
    return self;
}


@end
