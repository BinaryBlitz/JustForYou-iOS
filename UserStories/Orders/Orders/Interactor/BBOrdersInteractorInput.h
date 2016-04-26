//
//  BBOrdersInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JTCalendar/JTCalendar.h>

@protocol BBOrdersInteractorInput <NSObject>

- (void)initCalendarManagerWithCalendarView:(JTHorizontalCalendarView *)calendarView;


- (void)leftButtonDidTap;
- (void)rightButtonDidTap;

@end