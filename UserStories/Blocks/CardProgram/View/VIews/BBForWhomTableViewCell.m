//
//  BBForWhomTableViewCell.m
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBForWhomTableViewCell.h"

@implementation BBForWhomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDescriptions:(NSString *)first :(NSString *)second :(NSString *)third {
    self.first = first;
    self.second = second;
    self.third = third;
    self.descriptLabel.text = [NSString stringWithFormat:@"1. %@\n\n2. %@\n\n3. %@\n", first, second, third];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    CGRect contentViewFrame = self.contentView.frame;
//    contentViewFrame.origin.x = sideOffsetCell;
//    contentViewFrame.origin.y = sideOffsetCell;
//    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell*2;
////    contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - sideOffsetCell;
//    self.contentView.frame = contentViewFrame;
//}
//
//- (void)drawRect:(CGRect)rect {
//    
//    CAShapeLayer *borderLayer = [self _createBorderLayer];
//    CAShapeLayer * maskLayer = [CAShapeLayer layer];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
//    maskLayer.path = maskPath.CGPath;
//    borderLayer.path  = maskPath.CGPath;
//    self.contentView.layer.mask = maskLayer;
//    [self.contentView.layer addSublayer:borderLayer];
//}
//
//- (CAShapeLayer *)_createBorderLayer {
//    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
//    borderLayer.frame = self.contentView.bounds;
//    borderLayer.lineWidth = borderWightLineCell;
//    borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    
//    return borderLayer;
//}

@end

