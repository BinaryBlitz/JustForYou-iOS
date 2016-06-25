//
//  BBPaymentHistoryTableViewCell.h
//  JustForYou
//
//  Created by Антон on 10.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProgramHistory.h"

@interface BBPaymentHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@property (strong, nonatomic) BBProgramHistory *program;

@end
