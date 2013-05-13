//
//  SXFlightManager.h
//  AirPing
//
//  Created by Winfred Raguini on 4/25/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXFlightManager : NSObject
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSString *departureAirport;
@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic, strong) NSString *flightNumber;
+(SXFlightManager*)sharedManager;
@end
