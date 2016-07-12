//
//  BBMyOldProgramTableViewCell.m
//  JustForYou
//
//  Created by Антон on 10.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMyOldProgramTableViewCell.h"

@interface BBMyOldProgramTableViewCell()

@end

@implementation BBMyOldProgramTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPurchase:(BBPurchases *)purchase {
    _purchase = purchase;
    self.nameLabel.text = purchase.nameProgram;
    self.indicatorView.backgroundColor = purchase.elementBlock.colorBlock;
    self.subnameLabel.text = purchase.elementBlock.nameBlock;
    NSString *days = [BBConstantAndColor getNumberEndingWith:purchase.countDays andEndings:@[@"день", @"дня", @"дней"]];
    self.coundDayLabel.text = [NSString stringWithFormat:@"%ld %@", (long)purchase.countDays, days];
}

#pragma mark - Actions Methods

- (IBAction)replaceButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(replaceButtonDidTapWithPurchase:)]) {
        [self.delegate replaceButtonDidTapWithPurchase:self.purchase];
    }
}

- (IBAction)extendButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(extendButtonDidTapWithPurchase:)]) {
        [self.delegate extendButtonDidTapWithPurchase:self.purchase];
    }
}

#pragma mark - Draw Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.layer.masksToBounds = YES;
    self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame)/2;
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = sideOffsetCell;
    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell*2;
    contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - bottomOffsetCells;
    self.contentView.frame = contentViewFrame;
}

- (void)drawRect:(CGRect)rect {
    CAShapeLayer *borderLayer = [self _createBorderLayer];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
    maskLayer.path = maskPath.CGPath;
    borderLayer.path  = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
    [self.contentView.layer addSublayer:borderLayer];
}

- (CAShapeLayer *)_createBorderLayer {
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.contentView.bounds;
    borderLayer.lineWidth = borderWightLineCell;
    borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    return borderLayer;
}

@end
