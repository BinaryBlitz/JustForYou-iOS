//
//  BBSwitchTableViewCell.m
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBSwitchTableViewCell.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setRadius = NO;
    self.kSideCornerRadius = kNoneCornerRadius;
    self.kStyleContentCell = kStandartContentCell;
    self.keySwitch = kBonusesSwitch;
    [self.bonusSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setState:(id)sender {
    BOOL state = [sender isOn];
    
    if (self.keySwitch == kPushNotificationSwitch) {
        if (state == NO) {
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            NSString *tokenUser = [[BBUserService sharedService] tokenUser];
            if (tokenUser) {
                [[BBServerService sharedService] updateDeviceTokenWithApiToken:tokenUser deviceToken:nil completion:^(BBServerResponse *response, NSError *error) {
                }];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogOutUser object:nil];
            }
        } else {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(changeStateWithState:)]) {
            [self.delegate changeStateWithState:state];
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bonusSwitch.layer.cornerRadius = CGRectGetHeight(self.bonusSwitch.frame)/2;
    if (self.kStyleContentCell == kCardContentCell) {
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.origin.x = sideOffsetCell;
        
        contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell*2;
        self.contentView.frame = contentViewFrame;
    }
}

#pragma mark - Draw Methods

- (void)drawRect:(CGRect)rect {
    if (self.kStyleContentCell == kCardContentCell) {
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
