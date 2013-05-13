//
//  SXLocationClient.h
//  AirPing
//
//  Created by Winfred Raguini on 5/12/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface SXLocationClient : AFHTTPClient
+ (SXLocationClient *)sharedClient;
@end
