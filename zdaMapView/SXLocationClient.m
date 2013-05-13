//
//  SXLocationClient.m
//  AirPing
//
//  Created by Winfred Raguini on 5/12/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "SXLocationClient.h"

#define kLocationBaseURLString @"http://airping.co:8080/api/geo.php"

@implementation SXLocationClient
+ (SXLocationClient *)sharedClient {
    static SXLocationClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SXLocationClient alloc] initWithBaseURL:[NSURL URLWithString:kLocationBaseURLString]];
    });
    
    return _sharedClient;
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
