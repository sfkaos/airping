//
//  SXFlightAwareClient.m
//  AirPing
//
//  Created by Winfred Raguini on 4/24/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "SXFlightAwareClient.h"
#import "AFJSONRequestOperation.h"

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

@end
