//
//  customCellTableViewCell.h
//  CS147demo
//
//  Created by Louis Eugene on 04/11/2015.
//  Copyright © 2015 Louis Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
