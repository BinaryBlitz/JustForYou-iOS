//
//  BBAgreementTableViewCell.m
//  JustForYou
//
//  Created by Антон on 08.09.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAgreementTableViewCell.h"

#import "BBServerService.h"

@implementation BBAgreementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)licenseButtonAction:(id)sender {
    NSString *url = [[BBServerService sharedService] HOSTServer];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/credit_card_rules.docx", url]]];
}

@end
