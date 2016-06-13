//
//  BBNumderDayTableViewCell.m
//  JustForYou
//
//  Created by Антон on 18.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBNumderDayTableViewCell.h"

@implementation BBNumderDayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberDay = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDaysAndUpdateUI:(RLMResults *)days {
    self.caloriesLabel.text = [NSString stringWithFormat:@"0 Ккал"];
    [days sortedResultsUsingProperty:@"position" ascending:YES];
    self.days = days;
    BBDay *day = days.firstObject;
    [self updateDayLabelWithNumber:day.position];
}

- (IBAction)rightButtonAction:(id)sender {
    [self.delegate rightButtonDidTap];
}

- (IBAction)leftButtonAction:(id)sender {
    [self.delegate leftButtonDidTap];
}

- (void)updateDayLabelWithNumber:(NSInteger)number {
    self.numberDayLabel.text = [NSString stringWithFormat:@"%ld день", (long)number];
}

@end
