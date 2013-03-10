//
//  SXTimerViewController.h
//  zdaMapView
//
//  Created by Winfred Raguini on 3/9/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATPagingViewController.h"

@interface SXTimerViewController : UIViewController {
    int departureCounter;
    bool startA;
    NSTimer *departureTimer;
}
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *secondsA;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *etaTimer;
@property (nonatomic, retain, readwrite) ATPagingViewController *pagingController;
@end
