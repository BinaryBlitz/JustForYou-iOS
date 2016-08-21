//
//  BBTimeTableViewCell.h
//  JustForYou
//
//  Created by Антон on 21.08.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBTimeCellDelegate;

@interface BBTimeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (strong, nonatomic) id<BBTimeCellDelegate> delegate;

@end

@protocol BBTimeCellDelegate <NSObject>

- (void)presentAlertForMessage:(NSString *)message;

@end
