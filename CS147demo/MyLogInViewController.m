//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Let's customize Parse default login screen!
    
    // Background
    [self.logInView setBackgroundColor:[UIColor whiteColor]];
    
    // Logo
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StanfordSeal.gif"]]];
    [self.logInView.logo setFrame:CGRectMake(20.0f, 70.0f, 80.0f, 80.0f)];
    
    // Title and Subtitle
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(110, 75, 100, 40) ];
    title.text = @"CS 147";
    [title setFont:[UIFont fontWithName:@"Gill Sans" size:30.0f]];
    [self.view addSubview:title];
    
    UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(110, 95, 400, 40) ];
    subTitle.text = @"Human Computer Interaction";
    [subTitle setFont:[UIFont fontWithName:@"Gill Sans" size:18.0f]];
    [self.view addSubview:subTitle];
    
    // Useful variable
    float widthScreen = self.view.frame.size.width;
    
    // Login field
    fieldsBackground = [[UIImageView alloc] init];
    [fieldsBackground setImage:[UIImage imageNamed:@"loginField.png"]];
    [self.logInView addSubview:self.fieldsBackground];
    [self.logInView sendSubviewToBack:self.fieldsBackground];
    [self.fieldsBackground setFrame:CGRectMake((widthScreen-250)/2, 220.0f, 250.0f, 100.0f)];
    [self.logInView.usernameField setFrame:CGRectMake((widthScreen-250)/2, 220.0f, 250.0f, 50.0f)];
    [self.logInView.passwordField setFrame:CGRectMake((widthScreen-250)/2, 270.0f, 250.0f, 50.0f)];
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    
    // Login in and sign up
    
    float widthButton = 145;
    float heightButton = 60;
    float spacingButtons = 5;
    
    // Sign Up
    [self.logInView.signUpButton setFrame:CGRectMake((widthScreen-widthButton*2-spacingButtons)/2, 370.0f, widthButton, heightButton)];
    [self.logInView.signUpButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.signUpButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Log In
    [self.logInView.logInButton setFrame:CGRectMake((widthScreen-widthButton*2-spacingButtons)/2+widthButton+spacingButtons, 370.0f, widthButton, heightButton)];
    [self.logInView.logInButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.logInButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateHighlighted];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [self.logInView.logInButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.logInButton setTitle:@"" forState:UIControlStateHighlighted];
    
    
    // Facebook
    [self.logInView.facebookButton setFrame:CGRectMake((widthScreen-220)/2, 487.0f, 220.0f, 44.0f)];
    [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"fb_login.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
    
    
    
    // Some stuff we don't need
    self.logInView.signUpLabel.hidden=true;
    self.logInView.externalLogInLabel.hidden=true;
    self.logInView.dismissButton.hidden=true;
    self.logInView.twitterButton.hidden=true;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
