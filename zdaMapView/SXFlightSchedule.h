//
//  BoardingInfo.h
//  zdaMapView
//
//  Created by Winfred Raguini on 3/10/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXFlightSchedule : NSObject
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
@property (readonly) NSString *actualIdent;
@property (readonly) NSString *aircraftType;
@property (readonly) NSString *arrivalTime;
@property (readonly) NSString *departureTime;
@property (readonly) NSString *destination;
@property (readonly) NSString *ident;
@property (readonly) NSString *mealService;
@property (readonly) NSString *origin;
@property (readonly) NSString *seatsCabinBusiness;
@property (readonly) NSString *seatsCabinCoach;
@property (readonly) NSString *seatsCabinFirst;


- (id)initWithAttributes:(NSDictionary *)attributes;
@end
