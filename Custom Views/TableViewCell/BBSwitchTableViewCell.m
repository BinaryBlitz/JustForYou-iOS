//
//  BBSwitchTableViewCell.m
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBSwitchTableViewCell.h"

@implementation BBSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bonusSwitch.layer.cornerRadius = CGRectGetHeight(self.bonusSwitch.frame)/2;
}

@end
