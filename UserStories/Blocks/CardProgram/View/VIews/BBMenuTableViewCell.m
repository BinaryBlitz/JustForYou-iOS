//
//  BBMenuTableViewCell.m
//  JustForYou
//
//  Created by Антон on 15.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMenuTableViewCell.h"

static CGFloat cornerRadius = 4.0f;
static CGFloat lineWight = 1.0f;

@implementation BBMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myContentView.layer.masksToBounds = YES;
    self.myContentView.layer.cornerRadius = cornerRadius;
    self.myContentView.layer.borderWidth = lineWight;
    self.myContentView.layer.borderColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
