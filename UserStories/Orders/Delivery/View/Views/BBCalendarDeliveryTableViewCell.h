//
//  BBCalendarDeliveryTableViewCell.h
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

#import "BBOrderViewControllerDelegate.h"

@protocol BBCalendarDeliveryCellDelegate;

@interface BBCalendarDeliveryTableViewCell : UITableViewCell <BBOrderViewControllerDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@property (strong, nonatomic) id<BBCalendarDeliveryCellDelegate> delegate;

@end

@protocol BBCalendarDeliveryCellDelegate <NSObject>

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName;

@end
