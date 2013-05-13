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
@property (nonatomic, copy) NSString *actualIdent;
@property (nonatomic, copy) NSString *aircraftType;
@property (nonatomic, copy) NSString *arrivalTime;
@property (nonatomic, copy) NSString *departureTime;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *ident;
@property (nonatomic, copy) NSString *mealService;
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, copy) NSString *seatsCabinBusiness;
@property (nonatomic, copy) NSString *seatsCabinCoach;
@property (nonatomic, copy) NSString *seatsCabinFirst;


- (id)initWithAttributes:(NSDictionary *)attributes;
@end
