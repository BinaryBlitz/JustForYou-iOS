//
//  BBCalendarDeliveryTableViewCell.m
//  JustForYou
//
//  Created by Антон on 11.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarDeliveryTableViewCell.h"

#import "BBCalendarService.h"

@interface BBCalendarDeliveryTableViewCell() <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSString *nameMonth;

@property (strong, nonatomic) NSMutableArray *datesSelected;
@property (assign, nonatomic) BOOL selectDays;
@property (assign, nonatomic) BOOL selectWeekend;

@end

@implementation BBCalendarDeliveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initCalendarManager];
    self.purchaseColor = [BBConstantAndColor applicationGreenColor];
    self.selectDays = NO;
    self.selectWeekend = NO;
    self.countDayInOrder = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSArray *)selectedDays {
    return self.datesSelected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.delegate updateNameMonthPreviousName:@"" currentName:self.nameMonth nextName:@""];
    [self _setTextInLabel];
}

- (void)successivelySelectedDay {
    if ([self.datesSelected count] > 0 ) {
        if ([self.datesSelected count] < self.countDayInOrder) {
            self.datesSelected = [self.calendarManager.dateHelper daysFromCurrentDatesArray:self.datesSelected forInterval:self.countDayInOrder - [self.datesSelected count]];
            [self _setTextInLabel];
            [self.calendarManager reload];
        } else {
            [self.delegate showAlertViewWithMessage:@"Вы не можете больше выбирать дни"];
        }
    } else {
        [self.delegate showAlertViewWithMessage:@"Выберете хотя бы один день"];
    }
}

- (void)successivelySelectedDayWithoutWeekend {
    if ([self.datesSelected count] > 0) {
        if ([self.datesSelected count] < self.countDayInOrder) {
            self.datesSelected = [self.calendarManager.dateHelper daysWithoutWeekendFromCurrentDatesArray:self.datesSelected
                                                                                              forInterval:self.countDayInOrder - [self.datesSelected count]];
            [self _setTextInLabel];
            [self.calendarManager reload];
        } else {
            [self.delegate showAlertViewWithMessage:@"Вы не можете больше выбирать дни"];
        }
    } else {
        [self.delegate showAlertViewWithMessage:@"Выберете хотя бы один день"];
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
    if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = self.purchaseColor;
    } else {
        dayView.circleView.backgroundColor = [UIColor clearColor];
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    
    if([self isInDatesSelected:dayView.date]){
        [self _removeDayInArray:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:^(BOOL finished) {
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        }];
    } else {
        if ([[BBCalendarService sharedService] compareTwoDatesWithDay:dayView.date]) {
            if ([self.datesSelected count] < self.countDayInOrder) {
                [self _addDayInArray:dayView.date];
                
                dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                [UIView transitionWithView:dayView
                                  duration:.3
                                   options:0
                                animations:^{
                                    [_calendarManager reload];
                                    dayView.circleView.transform = CGAffineTransformIdentity;
                                } completion:nil];
            } else {
                [self.delegate showAlertViewWithMessage:@"Вы не можете больше выбирать дни"];
            }
        } else {
             [self.delegate showAlertViewWithMessage:@"Вы не можете выбрать прошедший день"];
        }
    }
    
}

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.delegate updateNameMonthPreviousName:previousName currentName:currentName nextName:nextName];
    if (!self.nameMonth || [self.nameMonth isEqualToString:@""]) {
        self.nameMonth = currentName;
    }
}


#pragma mark - DatesSelected Methods

- (BOOL)isInDatesSelected:(NSDate *)date {
    for(NSDate *dateSelected in self.datesSelected){
        if([self.calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    return NO;
}


- (void)_removeDayInArray:(NSDate *)date {
    [self.datesSelected removeObject:date];
    [self _sortedDateArray];
    [self _setTextInLabel];
}

- (void)_addDayInArray:(NSDate *)date {
    [self.datesSelected addObject:date];
    [self _sortedDateArray];
    [self _setTextInLabel];
}

- (void)_sortedDateArray {
    NSArray *sortedArray = [self.datesSelected sortedArrayUsingComparator: ^(NSDate *d1, NSDate *d2) {
        return [d1 compare:d2];
    }];
    self.datesSelected = [NSMutableArray arrayWithArray:sortedArray];
    if ([self.delegate respondsToSelector:@selector(currentArraySelectionDays:)]) {
        [self.delegate currentArraySelectionDays:self.datesSelected];
    }
}

- (void)_setTextInLabel {
    self.informationLabel.text = [NSString stringWithFormat:@"Выбрано %lu дней из %ld", (unsigned long)[self.datesSelected count], (long)self.countDayInOrder];
}

#pragma mark - Lazy Load

- (JTCalendarManager *) calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[JTCalendarManager alloc] init];
    }
    return _calendarManager;
}

- (NSMutableArray *)datesSelected {
    if (!_datesSelected) {
        _datesSelected = [[NSMutableArray alloc] init];
    }
    return _datesSelected;
}

@end
