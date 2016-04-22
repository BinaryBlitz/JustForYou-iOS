//
//  BBAccessoryTableViewCell.m
//  JustForYou
//
//  Created by Антон on 22.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAccessoryTableViewCell.h"

static CGFloat sizeFont = 16.0f;

@implementation BBAccessoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setRadius = NO;
    self.textLabel.font = [UIFont systemFontOfSize:sizeFont weight:UIFontWeightLight];
//    self.contentView.layer.shadowColor = [UIColor purpleColor].CGColor;
//    self.contentView.layer.shadowOffset = CGSizeMake(5, 5);
//    self.contentView.layer.shadowOpacity = 1;
//    self.contentView.layer.shadowRadius = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
