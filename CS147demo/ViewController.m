//
//  ViewController.m
//  CS147demo
//
//  Created by Louis Eugene on 29/10/2015.
//  Copyright © 2015 Louis Eugene. All rights reserved.
//

#import "ViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    // Some customization of the view
    
    // Add borders to "Yes" and "No" buttons
    
    // Yes
    self.yes.layer.cornerRadius = 5.0;
    self.yes.layer.borderWidth = 1.0f;
    self.yes.layer.borderColor = [UIColor grayColor].CGColor;
    
    // No
    self.no.layer.cornerRadius = 5.0;
    self.no.layer.borderWidth = 1.0f;
    self.no.layer.borderColor = [UIColor grayColor].CGColor;
    
}



- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Check if user is logged in. If not, we present Log In view
    
    if (![PFUser currentUser]) {
        
        // Customize the Log In View Controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions =  @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton | PFLogInFieldsLogInButton;
        
        // Customize the Sign Up View Controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
        logInViewController.signUpController = signUpViewController;
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}


// User click on "Yes" button
- (IBAction)yes:(id)sender {
    self.timeView.hidden=false;
}

// User click on "No" button
- (IBAction)no:(id)sender {
    
    self.timeView.hidden=true;
    self.yesAndNoView.hidden=true;
    self.finalview.hidden=false;
    self.result.text=@"This is bad!!!";
    
}

// "Action triggered on slider"
- (IBAction)sliderAction:(id)sender {
    self.timeLabel.text=[NSString stringWithFormat:@"%.f min",self.slider.value];
}

// User click on "Done" button to add attendance
- (IBAction)addAttendance:(id)sender {

    [self saveAttendanceToCloud];
    
    // Display the views we want
    self.timeView.hidden=true;
    self.yesAndNoView.hidden=true;
    self.finalview.hidden=false;
    
    // Custom message, based on time
    
    if (self.slider.value>80.0) {
        self.result.text=@"Super Great!";
    }
    else if (self.slider.value>40.0 && self.slider.value<80.0) {
        self.result.text=@"Great";
    }
    else {
        self.result.text=@"Pay more attention!";
    }
    
}

// Use Parse to save data
- (void)saveAttendanceToCloud {
    
    // Create an "Attendance" object taht we will save using Parse
    PFObject *myAttendance = [PFObject objectWithClassName:@"Attendance"];
    myAttendance[@"date"] = [NSDate date];
    myAttendance[@"time"] = [NSNumber numberWithFloat:self.slider.value];
    
    // Save our object
    [myAttendance saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            // If sucess, we link it to current user
            PFUser *user = [PFUser currentUser];
            PFRelation *relation = [user relationforKey:@"classAttendance"];
            [relation addObject:myAttendance];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // =)
                } else {
                    // There was a problem, check error.description
                }
            }];
            
        } else {
            // There was a problem, check error.description
        }
    }];
}

// Go back to first setup
- (IBAction)newEntry:(id)sender {
    
    self.timeView.hidden=true;
    self.yesAndNoView.hidden=false;
    self.finalview.hidden=true;
    self.no.hidden=false;
}



#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}




@end
