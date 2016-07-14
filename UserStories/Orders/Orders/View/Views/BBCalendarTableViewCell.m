//
//  BBCalendarTableViewCell.m
//  JustForYou
//
//  Created by Антон on 29.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarTableViewCell.h"

#import <JTCalendar/JTCalendar.h>

#import "BBOrder.h"
#import "BBCalendarService.h"

@interface BBCalendarTableViewCell () <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSString *nameMonth;

@property (strong, nonatomic) NSMutableDictionary *eventsByDate;
@property (strong, nonatomic) NSDate *dateSelected;
@property (strong, nonatomic) UIColor *selectedDayViewColor;

// aspect ratio for calendarView if line weak = 5 - 64:55
// aspect ratio for calendarView if line weak = 6 - 1:1

@end

@implementation BBCalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initCalendarManager];
    self.ordersForCalendar = [NSArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.delegate updateNameMonthPreviousName:@"" currentName:self.nameMonth nextName:@""];
}

- (void)setOrdersForCalendar:(NSArray *)ordersForCalendar {
    _ordersForCalendar = ordersForCalendar;
    [self updateEventsByDate];
    [self.calendarManager reload];
}

- (void)updateEventsByDate {
    self.eventsByDate = [NSMutableDictionary dictionary];
    for (BBOrder *order in self.ordersForCalendar) {
        NSDate *date = order.scheduledDay;
        NSString *key = [[self _dateFormatter] stringFromDate:date];
        if (!self.eventsByDate[key]) {
            NSMutableArray *programs = [NSMutableArray array];
            [programs addObject:order];
            [self.eventsByDate setObject:programs forKey:key];
        } else {
            NSMutableArray *prog = [self.eventsByDate objectForKey:key];
            [prog addObject:order];
            [self.eventsByDate setObject:prog forKey:key];
        }
    }
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
    
    self.calendarManager.settings.formatDay = JTCalendarFormatDayShortDay;
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
}

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
    
    dayView.hidden = NO;
    dayView.circleView.backgroundColor = [UIColor clearColor];
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Selected date
    else if(self.dateSelected && [self.calendarManager.dateHelper date:self.dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = self.selectedDayViewColor;
        
    } else {
        dayView.circleView.hidden = YES;
        dayView.circleView.backgroundColor = [UIColor clearColor];
    }

    if([self _haveEventForDay:dayView.date] /*&& ![self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]*/){
        dayView.circleView.hidden = NO;
        dayView.dotView.hidden = YES;
        NSArray *programs = [self programsInDay:dayView.date];
        
        NSMutableArray *colors = [NSMutableArray array];
        if ([dayView.dots count] < 1 || [dayView.dots count] < [programs count]) {
            for (BBOrder *order in programs) {
                UIColor *color = [UIColor colorWithRed:order.red green:order.green blue:order.blue alpha:1.0f];
                [colors addObject:color];
            }
            dayView.dots = [NSMutableArray array];
            if ([dayView.dots count] < [programs count]) {
                [dayView layoutIfNeeded];
            }
            [dayView initAndLayoutDotViewWithCountDots:[colors count] withColorSForDots:colors];
            [dayView layoutDots];
        }
        if(self.dateSelected && [self.calendarManager.dateHelper date:self.dateSelected isTheSameDayThan:dayView.date]){
            dayView.circleView.setBorderForView = NO;
            dayView.circleView.backgroundColor = self.selectedDayViewColor;
        } else if (![[BBCalendarService sharedService] compareTwoDatesWithDay:dayView.date]) {
            dayView.circleView.setBorderForView = YES;
            dayView.circleView.colorForBorderView = [BBConstantAndColor applicationGrayColor];
            [dayView.circleView setNeedsDisplay];
        }

    } else {
        dayView.dots = [NSMutableArray array];
        dayView.dotView.hidden = NO;
        [dayView layoutIfNeeded];
    }
    
    if([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        CGFloat size = dayView.textLabel.font.pointSize;
        dayView.textLabel.font = [UIFont boldSystemFontOfSize:size];
    } else {
        CGFloat size = dayView.textLabel.font.pointSize;
        dayView.textLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {

    if (self.dateSelected && [self.calendarManager.dateHelper date:self.dateSelected isTheSameDayThan:dayView.date]) {
        return;
    }
    self.dateSelected = dayView.date;
    NSArray *programs = [self programsInDay:dayView.date];
    [self.delegate dayViewDidTapWithOrders:programs];
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calendarManager reload];
                    } completion:nil];
    
}

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.delegate updateNameMonthPreviousName:previousName currentName:currentName nextName:nextName];
    if (!self.nameMonth || [self.nameMonth isEqualToString:@""]) {
        self.nameMonth = currentName;
    }
}

- (BOOL)_haveEventForDay:(NSDate *)date {
    NSString *key = [[self _dateFormatter] stringFromDate:date];
    if(self.eventsByDate[key]) {
        return YES;
    }
    return NO;
}


- (NSArray *)programsInDay:(NSDate *)date {
    NSString *key = [[self _dateFormatter] stringFromDate:date];
    return [self.eventsByDate objectForKey:key];
}

- (BOOL)isInDatesSelected:(NSDate *)date {
    if([self.calendarManager.dateHelper date:self.dateSelected isTheSameDayThan:date]){
        return YES;
    }
    
    return NO;
}

#pragma mark - Actions

- (IBAction)addNewOrderButtonAction:(id)sender {
    [self.delegate addNewOrderButtonDidTap];
}


#pragma mark - Lazy Load

- (JTCalendarManager *) calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
    }
    return _calendarManager;
}

- (UIColor *)selectedDayViewColor {
    if (!_selectedDayViewColor) {
        _selectedDayViewColor = [UIColor colorWithWhite:0.7 alpha:0.7];
    }
    return _selectedDayViewColor;
}

@end
