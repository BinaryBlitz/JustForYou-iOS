//
//  BBCalendarTableViewCell.m
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarTableViewCell.h"

#import <JTCalendar/JTCalendar.h>

@interface BBCalendarTableViewCell () <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSString *nameMonth;

@property (strong, nonatomic) NSMutableDictionary *eventsByDate;

@end

@implementation BBCalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _createRandomEvents];
    [self _initCalendarManager];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.delegate updateNameMonthPreviousName:@"" currentName:self.nameMonth nextName:@""];
}

#pragma mark - BBOrderViewControllerDelegate Methods

- (void)leftCalendarMenuButtonDidTap {
    [self.calendarView loadPreviousPageWithAnimation];
}

- (void)rightCalendarMenuButtonDidTap {
    [self.calendarView loadNextPageWithAnimation];
}


#pragma mark - Init Calendar Methods

- (void)_initCalendarManager {
    self.calendarView = self.calendarView;
    self.calendarManager.delegate = self;
    
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
}


- (void)_createRandomEvents {
    
    self.eventsByDate = [NSMutableDictionary new];
//    for(int i = 0; i < ; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:-(3600 * 24) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self _dateFormatter] stringFromDate:randomDate];
        
        if(!self.eventsByDate[key]){
            self.eventsByDate[key] = [NSMutableArray new];
        }
    
        [self.eventsByDate[key] addObject:randomDate];
//    }
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

#pragma mark - Calendar Delegate Methods
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
    
    if([self _haveEventForDay:dayView.date] /*&& ![self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]*/){
        dayView.circleView.hidden = NO;
//        dayView.dotView.hidden = NO;
//        dayView.dotView.backgroundColor = [BBConstantAndColor applicationGreenColor];
        dayView.circleView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
//        UIView *dot = dayView.dots[0];
//        UIView *dot1 = dayView.dots[1];
//        UIView *dot2 = dayView.dots[2];
//        dot.backgroundColor = [UIColor redColor];
//        dot1.backgroundColor = [BBConstantAndColor applicationGreenColor];
//        dot2.backgroundColor = [UIColor greenColor];

    }
    else{
        dayView.dotView.hidden = NO;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    
}

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.delegate updateNameMonthPreviousName:previousName currentName:currentName nextName:nextName];
    if (!self.nameMonth || [self.nameMonth isEqualToString:@""]) {
        self.nameMonth = currentName;
    }
}

- (BOOL)_haveEventForDay:(NSDate *)date {
    
    NSString *key = [[self _dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}


#pragma mark - Actions

- (IBAction)addNewOrderButtonAction:(id)sender {
    
}


#pragma mark - Lazy Load

- (JTCalendarManager *) calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
    }
    return _calendarManager;
}


@end
