//
//  SXFlightAwareClient.h
//  AirPing
//
//  Created by Winfred Raguini on 4/24/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "AFHTTPClient.h"

@interface SXFlightAwareClient : AFHTTPClient
+ (SXFlightAwareClient *)sharedClient;
- (void)setUsername:(NSString *)username andPassword:(NSString *)password;
@end
