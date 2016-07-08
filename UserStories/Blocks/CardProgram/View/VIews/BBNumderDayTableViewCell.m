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
    self.days = days;
}

- (IBAction)rightButtonAction:(id)sender {
    [self.delegate rightButtonDidTap];
}

- (IBAction)leftButtonAction:(id)sender {
    [self.delegate leftButtonDidTap];
}

- (void)updateDayLabelWithNumber:(NSInteger)number {
    if (([self.days count] > 0) && (number > 0)) {
        BBDay *day = [self.days objectsWhere:[NSString stringWithFormat:@"position=%ld", number]].firstObject;
        self.caloriesLabel.text = [NSString stringWithFormat:@"%ld Ккал", (long)day.calories];
        self.numberDayLabel.text = [NSString stringWithFormat:@"%ld день", (long)day.position];
    } else {
        self.caloriesLabel.text = [NSString stringWithFormat:@"%d Ккал", 0];
        self.numberDayLabel.text = [NSString stringWithFormat:@"%ld день", (long)number];
    }
}

@end
