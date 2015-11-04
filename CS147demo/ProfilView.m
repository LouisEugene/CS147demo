//
//  ProfilView.m
//  CS147demo
//
//  Created by Louis Eugene on 30/10/2015.
//  Copyright © 2015 Louis Eugene. All rights reserved.
//

#import "ProfilView.h"
#import "customCellTableViewCell.h"

@implementation ProfilView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Name and picture
    [self updateNameAndPicture];
    
    // Data of attendance
    [self updateTableView];
    

    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Customize Log Out
    self.logOut.backgroundColor=[UIColor colorWithRed:0.000f green:0.667f blue:0.973f alpha:1.00f];
    [self.logOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.logOut.layer.cornerRadius = 5.0;
    
    
}

- (void)updateNameAndPicture {
    
    if ([PFUser currentUser]) {
        // If the user is logged in
        
        if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
            // If user is linked to Facebook, we'll use the Facebook Graph API to fetch their full name.
            
            // Create Facebook Request for user's details
            FBRequest *request = [FBRequest requestForMe];
            
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                // This is an asynchronous method. When Facebook responds, if there are no errors, we'll update the name label.
                
                if (!error) {
                    
                    // Some info we can get, we will just use the first two
                    NSString *displayName = result[@"name"];
                    NSString *facebookID = result[@"id"];
                    NSString *location = result[@"location"][@"name"];
                    NSString *gender = result[@"gender"];
                    NSString *birthday = result[@"birthday"];
                    NSString *relationship = result[@"relationship_status"];
                    
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    if (displayName) {
                        self.nameLabel.text =[NSString stringWithFormat:NSLocalizedString(@"%@", nil), displayName];
                    }
                    
                    if(pictureURL) {
                        
                        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
                        
                        // Run network request asynchronously
                        [NSURLConnection sendAsynchronousRequest:urlRequest
                                                           queue:[NSOperationQueue mainQueue]
                                               completionHandler:
                         ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                             if (connectionError == nil && data != nil) {
                                 
                                 UIImage *tmpImage = [[UIImage alloc] initWithData:data];
                                 
                                 self.myPicture.image = tmpImage;
                                 self.myPicture.layer.cornerRadius = self.myPicture.frame.size.width / 2;
                                 self.myPicture.layer.masksToBounds = YES;
                                 self.myPicture.layer.borderWidth = 1.0f;
                                 self.myPicture.layer.borderColor = [UIColor blackColor].CGColor;
                             }
                         }];
                    }
                }
            }];
            
        } else {
            // If user is not linked to facebook, let's use their username
            self.nameLabel.text =[NSString stringWithFormat:NSLocalizedString(@"%@", nil), [PFUser currentUser].username];
        }
        
    } else {
        self.nameLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
    
}


- (void)updateTableView {
    
    // Initialize table data with Parse query
    PFRelation *relation = [[PFUser currentUser] relationforKey:@"classAttendance"];
    
    PFQuery *query = [relation query];
    [query orderByDescending:@"date"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // There was an error
        } else {
            
            // Data for table view
            tableData = [NSArray arrayWithArray:objects];
            
            // Count number elements
            self.attendanceCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)[tableData count]];
            
            [self.tableView reloadData];
            
        }
    }];
}

// Log Out
- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


// tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    customCellTableViewCell *cell = (customCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"tableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    PFObject *myAttendance = [tableData objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    
    NSString  *dateString=[dateFormat stringFromDate:myAttendance[@"date"]];
    
    float time = [myAttendance[@"time"] floatValue];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"Time: %.f min",time];
    cell.dateLabel.text = [NSString stringWithFormat:@"Date: %@", dateString];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}




@end
