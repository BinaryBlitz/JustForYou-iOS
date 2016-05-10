//
//  BBCalendarDeliveryTableViewCell.h
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

@interface BBCalendarDeliveryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@end
