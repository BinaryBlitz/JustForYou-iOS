//
//  BBMyCardTableViewCell.h
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBPayCard.h"

@interface BBMyCardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCardLabel;

@property (strong, nonatomic) BBPayCard *card;

@end
