//
//  ViewController.h
//  CS147demo
//
//  Created by Louis Eugene on 29/10/2015.
//  Copyright © 2015 Louis Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ViewController : UIViewController <PFLogInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *james;

@property (weak, nonatomic) IBOutlet UIView *yesAndNoView;
@property (weak, nonatomic) IBOutlet UIButton *yes;
@property (weak, nonatomic) IBOutlet UIButton *no;

@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *finalview;
@property (weak, nonatomic) IBOutlet UILabel *result;

- (IBAction)yes:(id)sender;
- (IBAction)no:(id)sender;
- (IBAction)sliderAction:(id)sender;
- (IBAction)addAttendance:(id)sender;
- (IBAction)newEntry:(id)sender;


@property (nonatomic, retain) CLLocationManager *locationManager;


@end

