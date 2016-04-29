//
//  BBCalendarTableViewCell.h
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTHorizontalCalendarView.h"

#import "BBDottedBorderButton.h"

#import "BBOrderViewControllerDelegate.h"

@protocol BBCalendarTableViewCellDelegate;

@interface BBCalendarTableViewCell : UITableViewCell <BBOrderViewControllerDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet BBDottedBorderButton *addNewOrderButton;

@property (strong, nonatomic) id<BBCalendarTableViewCellDelegate> delegate;

@end

@protocol BBCalendarTableViewCellDelegate <NSObject>

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName;

@end