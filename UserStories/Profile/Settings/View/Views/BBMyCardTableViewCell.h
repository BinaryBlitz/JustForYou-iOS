//
//  BBMyCardTableViewCell.h
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMyCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namePaySystemLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconPaySystem;

@end
