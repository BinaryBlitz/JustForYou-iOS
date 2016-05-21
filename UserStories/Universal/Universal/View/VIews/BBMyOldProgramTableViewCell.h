//
//  BBMyOldProgramTableViewCell.h
//  JustForYou
//
//  Created by Антон on 10.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMyOldProgramTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coundDayLabel;
@property (weak, nonatomic) IBOutlet UIButton *replaceButton;
@property (weak, nonatomic) IBOutlet UIButton *extendButton;


@end
