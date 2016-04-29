//
//  BBInfoRegistTableViewCell.h
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBUnderlineButton.h"

@interface BBInfoRegistTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BBUnderlineButton *sendAgainButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
