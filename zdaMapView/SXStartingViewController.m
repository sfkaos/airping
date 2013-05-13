//
//  SXStartingViewController.m
//  AirPing
//
//  Created by Winfred Raguini on 5/12/13.
//  Copyright (c) 2013 AirPing.co. All rights reserved.
//

#import "SXStartingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SXTimerViewController.h"
#import "SXFlightManager.h"

@interface SXStartingViewController ()

@end

@implementation SXStartingViewController

UITextField *activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    
    
    NSLog(@"date is %@", [NSDate dateWithTimeIntervalSince1970:1368433200]);
    
    // Do any additional setup after loading the view from its nib.
    self.buttonView.layer.cornerRadius = 10.0f;
    self.buttonView.layer.masksToBounds = YES;
    
    self.containerView.layer.cornerRadius = 10.0f;
    self.containerView.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.size.height = 240.0f;
    [self.scrollView setFrame:scrollViewFrame];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 140.0f)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginButtonSelected:(id)sender
{
    if ([self validateFields]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [[SXTimerViewController alloc] initWithNibName:@"SXTimerViewController" bundle:nil];
        [window makeKeyAndVisible];
    }
}


#pragma mark
#pragma mark Private

- (BOOL)validateFields
{
    if (([self.departureAirportField.text length] > 0) && ([self.departureDateField.text length] > 0) && ([self.flightNumberField.text length] > 0)) {
        [[SXFlightManager sharedManager] setFlightNumber:self.flightNumberField.text];
        [[SXFlightManager sharedManager] setDepartureAirport:self.departureAirportField.text];
        
        NSArray *dateArray = [self.departureDateField.text componentsSeparatedByString:@"/"];
        
        NSLog(@"dateArray %@", dateArray);
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:[[dateArray objectAtIndex:0] intValue]];
        [comps setDay:[[dateArray objectAtIndex:1] intValue]];
        
        NSString *year = [dateArray objectAtIndex:2];
        if ([year length] == 2) {
            year = [NSString stringWithFormat:@"20%@", year];
        } else {
            UIAlertView *badYearFieldAlert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"The year must be entered with 4 digits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [badYearFieldAlert show];
        }
        
        [comps setYear:[year intValue]];
        
        NSDate *departureDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
    
        [[SXFlightManager sharedManager] setDepartureDate:departureDate];
        NSLog(@"Departure date is %@", departureDate);
        return YES;
    } else {
        UIAlertView *missingFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Fill out all of the missing fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [missingFieldsAlert show];
        return NO;
    }
}

#pragma mark - UITextFieldDelegate protocol method

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    activeField = textField;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField

{
    activeField = nil;
}

//Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = activeField.frame.origin;
    origin.y += self.scrollView.frame.origin.y;
    
    NSLog(@"keyBoard height is %1.2f", kbSize.height);
    
    NSLog(@"the view frame is now origin x: %1.2f, origin y:%1.2f, width:%1.2f, height:%1.2f", self.view.frame.origin.x, self.view.frame.origin.y, aRect.size.width, aRect.size.height);
    
    NSLog(@"aRect origin x:%1.2f origin y:%1.2f", origin.x, origin.y);
    
    NSLog(@"activeField origin.y %1.2f", activeField.frame.origin.y);
    
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, (activeField.frame.origin.y + 15.0f + self.scrollView.frame.origin.y) -(aRect.size.height));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

//- (void)keyboardWasShown:(NSNotification*)aNotification {
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    CGRect bkgndRect = activeField.superview.frame;
//    bkgndRect.size.height += kbSize.height;
//    [activeField.superview setFrame:bkgndRect];
//    [self.scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
//}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


- (IBAction)endEdittingButtonSelected:(id)sender
{
    [self.view endEditing:YES];
}


@end
