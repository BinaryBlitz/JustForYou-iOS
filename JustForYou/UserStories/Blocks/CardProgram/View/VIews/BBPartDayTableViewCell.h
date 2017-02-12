//
//  BBPartDayTableViewCell.h
//  JustForYou
//
//  Created by Антон on 18.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBPartDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *partOfDayLabel;

- (void)setPartOfDayWithKey:(BBPartOfDay) key;

@end
