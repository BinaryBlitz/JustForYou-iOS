//
//  BBTextTableViewCell.m
//  JustForYou
//
//  Created by Антон on 28.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTextTableViewCell.h"

@interface BBTextTableViewCell() <UITextFieldDelegate>

@end

@implementation BBTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
