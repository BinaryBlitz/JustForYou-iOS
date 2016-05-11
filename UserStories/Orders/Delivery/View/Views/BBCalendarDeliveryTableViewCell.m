//
//  BBCalendarDeliveryTableViewCell.m
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarDeliveryTableViewCell.h"

@interface BBCalendarDeliveryTableViewCell() <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSString *nameMonth;

@property (strong, nonatomic) UIColor *selectedDayViewColor;
@property (strong, nonatomic) NSMutableArray *datesSelected;

@end

@implementation BBCalendarDeliveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
    
    self.calendarManager.settings.formatDay = JTCalendarFormatDayShortDay;
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
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
    
    dayView.hidden = NO;
    dayView.circleView.backgroundColor = [UIColor clearColor];
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = self.selectedDayViewColor;
    } else {
        dayView.circleView.backgroundColor = [UIColor clearColor];
    }
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    
    if([self isInDatesSelected:dayView.date]){
        [self.datesSelected removeObject:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:nil];
    }
    else{
        [self.datesSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    }
    
}

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.delegate updateNameMonthPreviousName:previousName currentName:currentName nextName:nextName];
    if (!self.nameMonth || [self.nameMonth isEqualToString:@""]) {
        self.nameMonth = currentName;
    }
}


- (BOOL)isInDatesSelected:(NSDate *)date {
    for(NSDate *dateSelected in self.datesSelected){
        if([self.calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
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

- (UIColor *)selectedDayViewColor {
    if (!_selectedDayViewColor) {
        _selectedDayViewColor = [UIColor colorWithWhite:0.7 alpha:0.7];
    }
    return _selectedDayViewColor;
}

- (NSMutableArray *)datesSelected {
    if (!_datesSelected) {
        _datesSelected = [[NSMutableArray alloc] init];
    }
    return _datesSelected;
}

@end
