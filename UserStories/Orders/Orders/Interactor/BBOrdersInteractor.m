//
//  BBOrdersInteractor.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersInteractor.h"

#import "BBOrdersInteractorOutput.h"

@interface BBOrdersInteractor() <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) JTHorizontalCalendarView *calendarView;

@end

@implementation BBOrdersInteractor

#pragma mark - Методы BBOrdersInteractorInput

- (void)initCalendarManagerWithCalendarView:(JTHorizontalCalendarView *)calendarView
                              previousLabel:(UILabel *)previousLabel
                               currentLabel:(UILabel *)currentLabel
                                  netxLabel:(UILabel *)nextLabel {
    self.calendarView = calendarView;
    
    self.calendarManager.delegate = self;
    
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
    

}

#pragma mark - Calendar Delegate

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {

    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    else if([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.dotView.hidden = YES;
        dayView.circleView.backgroundColor = [UIColor clearColor];
        //        [dayView.colorsForDots addObject:[UIColor redColor]];
        //        [dayView.colorsForDots addObject:[UIColor redColor]];
        //        [dayView.colorsForDots addObject:[UIColor blueColor]];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    
}

#pragma mark - Lazy Load

- (JTCalendarManager *) calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
    }
    return _calendarManager;
}


@end