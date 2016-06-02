//
//  BBInfoRegistTableViewCell.m
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBInfoRegistTableViewCell.h"


@interface BBInfoRegistTableViewCell ()

@end

@implementation BBInfoRegistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.keyStyleCell = kBigInfoRegistCellStyle;
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.sendCodeButton.layer.masksToBounds = YES;
    self.sendCodeButton.layer.cornerRadius = CGRectGetHeight(self.sendCodeButton.frame)/2;
}

- (IBAction)sendCodeButtonAction:(id)sender {
    self.sendCodeButton.enabled = NO;
    HQDispatchAfter(5, ^{
        self.sendCodeButton.enabled = YES;
    });
    [self.delegate sendCodeButtonDidTap];
}

- (void)drawRect:(CGRect)rect {
    if (self.keyStyleCell == kBigInfoRegistCellStyle) {
        self.infoLabel.hidden = YES;
        self.sendAgainButton.hidden = YES;
        self.sendCodeButton.hidden = NO;
    } else {
        self.infoLabel.hidden = NO;
        self.sendAgainButton.hidden = NO;
        self.sendCodeButton.hidden = YES;
    }
}

@end
