//
//  SXTimerViewController.h
//  zdaMapView
//
//  Created by Winfred Raguini on 3/9/13.
//  Copyright (c) 2013 Unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATPagingViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SXTimerViewController : UIViewController <CLLocationManagerDelegate> {
    int departureCounter;
    int etaCounter;
    bool startA;
    bool startETACounter;
    NSTimer *departureTimer;
    NSTimer *etaTimer;
    
}
@property (nonatomic, retain) IBOutlet UIButton *settingsButton;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *secondsA;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *etaTimer;
@property (nonatomic, retain) IBOutlet UIView *etaAlertView;
@property (nonatomic, retain, readwrite) ATPagingViewController *pagingController;
- (IBAction)settingsButtonSelected:(id)sender;
- (IBAction)backButtonSelected:(id)sender;
@end
