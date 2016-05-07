//
//  BBMyProgramTableViewCell.m
//  JustForYou
//
//  Created by Антон on 06.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMyProgramTableViewCell.h"

static CGFloat sideOffest = 14.0f;
static CGFloat bottomOffest = 10.0f;
static CGFloat cornerRadius = 4.0f;
static CGFloat borderLineWight = 1.0f;

@implementation BBMyProgramTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.keyMode = kProgramCellModeDefault;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.layer.masksToBounds = YES;
    self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame)/2;
    
    if (self.keyMode == kProgramCellModeCornerRadius) {
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.origin.x = sideOffest;
        contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffest*2;
        contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - bottomOffest;
        self.contentView.frame = contentViewFrame;
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.keyMode == kProgramCellModeCornerRadius) {
        CAShapeLayer *borderLayer = [self _createBorderLayer];
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        maskLayer.path = maskPath.CGPath;
        borderLayer.path  = maskPath.CGPath;
        self.contentView.layer.mask = maskLayer;
        [self.contentView.layer addSublayer:borderLayer];
    }
}

- (CAShapeLayer *)_createBorderLayer {
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.contentView.bounds;
    borderLayer.lineWidth = borderLineWight;
    borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    return borderLayer;
}

@end
