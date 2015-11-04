//
//  ProfilView.h
//  CS147demo
//
//  Created by Louis Eugene on 30/10/2015.
//  Copyright © 2015 Louis Eugene. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ProfilView : ViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *tableData;
}


@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myPicture;

@property (weak, nonatomic) IBOutlet UILabel *attendanceCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *logOut;

- (IBAction)logOutButtonTapAction:(id)sender;

@end
