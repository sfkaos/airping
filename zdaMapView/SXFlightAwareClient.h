//
//  SXFlightAwareClient.h
//  AirPing
//
//  Created by Winfred Raguini on 4/24/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "AFHTTPClient.h"
#import "SXFlightAwareClient.h"



@interface SXFlightAwareClient : AFHTTPClient
@property (nonatomic, assign) id delegate;
+ (SXFlightAwareClient *)sharedClient;
- (void)setUsername:(NSString *)username andPassword:(NSString *)password;
- (void)searchForFlightsWithParameters:(NSDictionary*)param;
@end

@protocol  SXFlightManagerDelegate
- (void)flightHTTPClient:(SXFlightAwareClient*)client didFindFlights:(NSArray*)flightsArray;
@end