//
//  BBHeaderTableViewCell.m
//  JustForYou
//
//  Created by Антон on 09.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBHeaderTableViewCell.h"

@implementation BBHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentedControlAction:(id)sender {
    [self.segmentedControl setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(segmentedControlValueChange:)]) {
        [self.delegate segmentedControlValueChange:self.segmentedControl.selectedSegmentIndex];
    }
}

- (void)drawRect:(CGRect)rect {
    [self.contentView sendSubviewToBack:self.imageProgram];
}

@end
