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
    self.countLabel.hidden = YES;
    self.kSideCornerRadius = kNoneCornerRadius;
    self.textLabel.font = [UIFont systemFontOfSize:sizeFont weight:UIFontWeightLight];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = sideOffsetCell;
    
    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell*2;
    self.contentView.frame = contentViewFrame;
    UIView *backgroundView = [[UIView alloc] initWithFrame:contentViewFrame];
    self.selectedBackgroundView = backgroundView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - Draw Methods 

- (void)drawRect:(CGRect)rect {
    CAShapeLayer *borderLayer = [self _createBorderLayer];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath;
    
    if (self.setRadius == YES) {
        if (self.kSideCornerRadius == kTopCornerRadius) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
            maskLayer.path = maskPath.CGPath;
        }
        if (self.kSideCornerRadius == kBottomCornerRadius) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect: self.contentView.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
            maskLayer.path = maskPath.CGPath;
        }
        if (self.kSideCornerRadius == kAllCornerRadius) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect: self.contentView.bounds byRoundingCorners: UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
            maskLayer.path = maskPath.CGPath;
        }
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeZero];
        maskLayer.path = maskPath.CGPath;
    }
    
    borderLayer.path  = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
    [self.contentView.layer addSublayer:borderLayer];
}

- (CAShapeLayer *)_createBorderLayer {
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.contentView.bounds;
    borderLayer.lineWidth   = borderWightLineCell;
    borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
    borderLayer.fillColor   = [UIColor clearColor].CGColor;
    
    return borderLayer;
}

@end
