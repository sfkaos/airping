//
//  SXFlightManager.m
//  AirPing
//
//  Created by Winfred Raguini on 4/25/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "SXFlightManager.h"
#import "SXFlightAwareClient.h"
#import "SXFlightSchedule.h"



@implementation SXFlightManager
+(SXFlightManager*)sharedManager
{
    static SXFlightManager* _theManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _theManager = [[SXFlightManager alloc] init];
    });
    return _theManager;
}

@end
