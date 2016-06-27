//
//  BBBasketTableViewCell.m
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBBasketTableViewCell.h"

#import "BBUserService.h"

static NSString *kNameMinusImage = @"minusIcon";
static NSString *kNameCrossImage = @"crossIcon";

@implementation BBBasketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setters Methods

- (void)setProgram:(BBProgram *)program {
    _program = program;
    self.nameLabel.text = program.name;
    self.costLabel.text = [NSString stringWithFormat:@"%ld P", (long)program.primaryPrice];
}

- (void)setOrderProgram:(BBOrderProgram *)orderProgram {
    _orderProgram = orderProgram;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)orderProgram.countDays];
    if (self.orderProgram.countDays >= 2) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    } else {
        [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
    }
}

#pragma mark - UI Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.layer.masksToBounds = YES;
    self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame)/2;
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = sideOffsetCell;
    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell*2;
    contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - sideOffsetCell;
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

#pragma mark - Actions Methods

- (IBAction)closeButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closeButtonDidTapWithBasketCell:)]) {
        [self.delegate closeButtonDidTapWithBasketCell:self];
    }
}

- (IBAction)leftButtonAction:(id)sender {
    if (self.orderProgram.countDays > 2) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    } else {
        [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
    }
    if (self.orderProgram.countDays != 1) {
        self.orderProgram.countDays--;
    }
    [[BBUserService sharedService] updateOrderProgramWithOrderProgram:self.orderProgram];
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.orderProgram.countDays];
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.orderProgram.countDays == 1) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    }
    self.orderProgram.countDays++;
    [[BBUserService sharedService] updateOrderProgramWithOrderProgram:self.orderProgram];
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.orderProgram.countDays];
}

- (void)_changeBackgroundImageInButtonWithName:(NSString *)image {
    [self.leftButton setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
}

@end
