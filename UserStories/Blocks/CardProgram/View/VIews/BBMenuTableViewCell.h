//
//  BBMenuTableViewCell.h
//  JustForYou
//
//  Created by Антон on 15.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *myContentView;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
