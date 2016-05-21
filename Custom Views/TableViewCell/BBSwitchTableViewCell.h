//
//  BBSwitchTableViewCell.h
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *bonusSwitch;
@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;
@property (nonatomic) BBKeyStyleContentCell kStyleContentCell;

@end