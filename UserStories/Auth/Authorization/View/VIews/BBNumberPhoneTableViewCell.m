//
//  BBNumberPhoneTableViewCell.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBNumberPhoneTableViewCell.h"

#import "BBValidationService.h"

@interface BBNumberPhoneTableViewCell() <UITextFieldDelegate>

@end

@implementation BBNumberPhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.numberTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (IBAction)textFieldDidBeginEditing:(id)sender {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString* totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];

    if (range.length == 1) {
        textField.text = [BBValidationService validateNumberPhoneWithNumber:totalString deleteLastChar:YES];
    } else {
        textField.text = [BBValidationService validateNumberPhoneWithNumber:totalString deleteLastChar:NO];
    }
    return NO;
}

@end
