//
//  BBSwitchTableViewCell.h
//  JustForYou
//
//  Created by Антон on 07.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kBonusesSwitch,
    kPushNotificationSwitch
}BBKeyForSwitch;

@protocol BBSwitchCellDelegate;

@interface BBSwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *bonusSwitch;
@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;


@property (strong, nonatomic) id<BBSwitchCellDelegate> delegate;

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;
@property (nonatomic) BBKeyStyleContentCell kStyleContentCell;
@property (nonatomic) BBKeyForSwitch keySwitch;

@end

@protocol BBSwitchCellDelegate <NSObject>

@optional
- (void)changeStateWithState:(BOOL)state;

@end