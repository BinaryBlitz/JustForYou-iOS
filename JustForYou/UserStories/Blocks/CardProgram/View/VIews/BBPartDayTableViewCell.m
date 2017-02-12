//
//  BBPartDayTableViewCell.m
//  JustForYou
//
//  Created by Антон on 18.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPartDayTableViewCell.h"

@implementation BBPartDayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPartOfDayWithKey:(BBPartOfDay) key {
    if (key == kMorningPartOfDay) {
        self.partOfDayLabel.text = @"УТРО";
    } else if (key == kDayPartOfDay) {
        self.partOfDayLabel.text = @"ДЕНЬ";
    } else {
        self.partOfDayLabel.text = @"ВЕЧЕР";
    }
}

@end
