//
//  BBPreviewOrderTableViewCell.h
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBPreviewOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameProgramLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *adresLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
