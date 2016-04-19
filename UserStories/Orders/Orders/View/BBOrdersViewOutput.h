//
//  BBOrdersViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JTCalendar/JTCalendar.h>

@protocol BBOrdersViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)initCalendarManagerWithCalendarView:(JTHorizontalCalendarView *)calendarView previousLabel:(UILabel *)previousLabel currentLabel:(UILabel *)currentLabel netxLabel:(UILabel *)nextLabel;

@end