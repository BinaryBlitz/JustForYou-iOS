//
//  BBNumberPhoneTableViewCell.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBNumberPhoneTableViewCell.h"

@interface BBNumberPhoneTableViewCell() <UITextFieldDelegate>

@end

@implementation BBNumberPhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.numberTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)textFieldDidBeginEditing:(id)sender {
    
}

@end