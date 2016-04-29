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

@property (strong, nonatomic) NSMutableDictionary *eventsByDate;


@end

@implementation BBOrdersInteractor

#pragma mark - Методы BBOrdersInteractorInput

- (void)initCalendarManagerWithCalendarView:(JTHorizontalCalendarView *)calendarView {
    self.calendarView = calendarView;
    
    self.calendarManager.delegate = self;
    
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
    
    [self _createRandomEvents];
}

- (void)leftButtonDidTap {
    [self.calendarView loadPreviousPageWithAnimation];
}

- (void)rightButtonDidTap {
    [self.calendarView loadNextPageWithAnimation];
}

#pragma mark - Calendar Delegate

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {

    [dayView.colorsForDots addObject:[UIColor clearColor]];
    [dayView.colorsForDots addObject:[UIColor clearColor]];
    [dayView.colorsForDots addObject:[UIColor clearColor]];
    
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    else if([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.dotView.hidden = YES;
        dayView.circleView.backgroundColor = [UIColor clearColor];
//                [dayView.colorsForDots addObject:[UIColor redColor]];
//                [dayView.colorsForDots addObject:[UIColor redColor]];
        //        [dayView.colorsForDots addObject:[UIColor blueColor]];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
//    if([self _haveEventForDay:dayView.date] && ![self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
//        dayView.circleView.hidden = NO;
//        dayView.dotView.hidden = YES;
//        dayView.circleView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
//        UIView *dot = dayView.dots[0];
//        UIView *dot2 = dayView.dots[2];
//        dot.backgroundColor = [UIColor redColor];
//        dot2.backgroundColor = [UIColor greenColor];

//    }
    else{
        dayView.dotView.hidden = NO;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    
}

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.output nameMonthPreviousName:previousName currentName:currentName nextName:nextName];
}

- (void)_createRandomEvents {
    
    self.eventsByDate = [NSMutableDictionary new];
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self _dateFormatter] stringFromDate:randomDate];
        
        if(!self.eventsByDate[key]){
            self.eventsByDate[key] = [NSMutableArray new];
        }
        
        [self.eventsByDate[key] addObject:randomDate];
    }
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)_dateFormatter {
    
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)_haveEventForDay:(NSDate *)date {
    
    NSString *key = [[self _dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

#pragma mark - Lazy Load

- (JTCalendarManager *) calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
    }
    return _calendarManager;
}


@end