//
//  BBAddressTableViewCell.m
//  JustForYou
//
//  Created by Антон on 02.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddressTableViewCell.h"

@implementation BBAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateTextLabelWithAddress {
    self.textLabel.text = self.address.address;
}

@end
