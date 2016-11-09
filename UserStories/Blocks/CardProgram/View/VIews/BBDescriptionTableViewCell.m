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
    self.costLabel.text = [BBConstantAndColor formatedStringForOneDayWithProgram:program];
    self.bigCostLabel.text = [BBConstantAndColor formatedStringForAnyDayWithProgram:program];
    self.descriptionLabel.text = program.descript;
}

@end
