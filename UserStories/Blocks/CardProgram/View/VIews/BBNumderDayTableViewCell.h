//
//  BBNumderDayTableViewCell.h
//  JustForYou
//
//  Created by Антон on 18.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBNumberDayTableViewCell;

@interface BBNumderDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (nonatomic) NSInteger numberDay;

@property (strong, nonatomic) id<BBNumberDayTableViewCell> delegate;

- (void)updateDayLabelWithNumber:(NSInteger)number;

@end

@protocol BBNumberDayTableViewCell <NSObject>

- (void)leftButtonDidTap;
- (void)rightButtonDidTap;

@end