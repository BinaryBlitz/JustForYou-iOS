//
//  BBDescriptionTableViewCell.m
//  JustForYou
//
//  Created by Антон on 15.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBDescriptionTableViewCell.h"

@implementation BBDescriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadUIWithProgram:(BBProgram *)program {
    self.program = program;
    if (program.name) {
        self.nameLabel.text = program.name;
    } else {
        self.nameLabel.text = @"";
    }
    NSString *day = @"";
    if (self.program.threshold == 1) {
        day = [NSString stringWithFormat:@"При заказе от %ld дня: %ld Р",(long)program.threshold, (long)program.secondaryPrice];
    } else {
        day = [NSString stringWithFormat:@"При заказе от %ld дней: %ld Р",(long)program.threshold, (long)program.secondaryPrice];
    }
    self.costLabel.text = [NSString stringWithFormat:@"Цена за 1 день: %ld Р", (long)self.program.primaryPrice];
    self.bigCostLabel.text = day;
    self.descriptionLabel.text = program.descript;
}

@end
