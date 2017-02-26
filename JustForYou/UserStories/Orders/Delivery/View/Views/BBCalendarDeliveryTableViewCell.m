

#import "BBCalendarService.h"
#import "BBDataBaseService.h"

@interface BBCalendarDeliveryTableViewCell () <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSString *nameMonth;

@property (strong, nonatomic) NSArray *ordersForCalendar;
@property (strong, nonatomic) NSMutableDictionary *eventsByDate;

@property (strong, nonatomic) NSMutableArray *datesSelected;
@property (assign, nonatomic) BOOL selectDays;
@property (assign, nonatomic) BOOL selectWeekend;

@property (assign, nonatomic) BOOL loadNextPage;

@end

NSInteger maximumOrderHour = 11;

@implementation BBCalendarDeliveryTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  [self _initCalendarManager];
  self.purchaseColor = [BBConstantAndColor applicationGreenColor];
  self.selectDays = NO;
  self.selectWeekend = NO;
  self.loadNextPage = YES;
  self.countDayInOrder = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (NSArray *)selectedDays {
  return self.datesSelected;
}

- (void)setSelectionDays:(NSArray *)days {
  self.datesSelected = [NSMutableArray arrayWithArray:days];
  [self _sortedDateArray];
  [self listMyDeliveriesOnDataBase];
}

- (void)listMyDeliveriesOnDataBase {
  HQDispatchToMainQueue(^{
    self.ordersForCalendar = [[BBDataBaseService sharedService] ordersInRealm];
    self.eventsByDate = [[BBCalendarService sharedService] updateEventsByDateForOrders:self.ordersForCalendar events:self.eventsByDate];
    [self.calendarManager reload];
  });
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.delegate updateNameMonthPreviousName:@"" currentName:self.nameMonth nextName:@""];
  [self _setTextInLabel];
}

- (void)successivelySelectedDay {
  self.loadNextPage = YES;
  if ([self.datesSelected count] > 0) {
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
  self.loadNextPage = YES;
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
  self.calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];

  [self.calendarManager setContentView:self.calendarView];
  [self.calendarManager setDate:[NSDate date]];
}

#pragma mark - Calendar Delegate Methods

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {

  dayView.hidden = NO;
  dayView.circleView.backgroundColor = [UIColor clearColor];
  // Other month
  if ([dayView isFromAnotherMonth]) {
    dayView.hidden = YES;
  }

  // Selected date
  if ([self isInDatesSelected:dayView.date]) {
    dayView.circleView.hidden = NO;
    dayView.circleView.backgroundColor = self.purchaseColor;
  } else {
    dayView.circleView.hidden = YES;
    dayView.circleView.backgroundColor = [UIColor clearColor];
    //Today
    if ([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]) {
      dayView.circleView.hidden = NO;
      dayView.circleView.backgroundColor = [BBConstantAndColor applicationOrangeColorWithAlpha:0.3f];
    }
  }

  if ([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]) {
    dayView.circleView.hidden = NO;
    dayView.circleView.backgroundColor = [BBConstantAndColor applicationOrangeColorWithAlpha:0.3f];
  }
  if ([self _haveEventForDay:dayView.date] /*&& ![self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]*/) {
    dayView.circleView.hidden = NO;
    dayView.dotView.hidden = YES;
    NSArray *programs = [self programsInDay:dayView.date];
    if ([programs count] > 3) {
      NSMutableArray *array = [NSMutableArray arrayWithArray:programs];
      [array removeLastObject];
      programs = array;
    }
    NSMutableArray *colors = [NSMutableArray array];
    if ([dayView.dots count] < 1 || [dayView.dots count] < [programs count] || [dayView.dots count] > [programs count]) {
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

    if ([self isInDatesSelected:dayView.date]) {
      dayView.circleView.setBorderForView = NO;
      dayView.circleView.backgroundColor = self.purchaseColor;
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

  if ([self isInDatesSelected:dayView.date] && ![self.calendarManager.dateHelper date:self.calendarView.date isTheSameMonthThan:dayView.date]) {
    if (self.loadNextPage) {
      if ([self.calendarView.date compare:dayView.date] == NSOrderedAscending) {
        [self.calendarView loadNextPageWithAnimation];
      }
      self.loadNextPage = NO;
    }
  }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {

  if ([self isInDatesSelected:dayView.date]) {
    [self _removeDayInArray:dayView.date];

    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                      [self.calendarManager reload];
                      dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                    } completion:^(BOOL finished) {
                      dayView.circleView.transform = CGAffineTransformIdentity;
                    }];
  } else {
    if ([[BBCalendarService sharedService] compareTwoDatesWithDay:dayView.date]) {
      NSInteger selectedDay = [[BBCalendarService sharedService] getCalendarDay:dayView.date];
      NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour fromDate:[NSDate date]];
      if ([currentDateComponents hour] >= maximumOrderHour && selectedDay - [currentDateComponents day] <= 1) {
        [self.delegate showAlertViewWithMessage:@"Заказать доставку на следующий день можно только до 11:00"];
      } else if ([self.datesSelected count] < self.countDayInOrder) {
        [self _addDayInArray:dayView.date];
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                          dayView.circleView.transform = CGAffineTransformIdentity;
                          [self.calendarManager reload];
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
  self.nameMonth = currentName;
}

- (BOOL)_haveEventForDay:(NSDate *)date {
  NSString *key = [[[BBCalendarService sharedService] dateFormatter] stringFromDate:date];
  if (self.eventsByDate[key]) {
    return YES;
  }
  return NO;
}

- (NSArray *)programsInDay:(NSDate *)date {
  NSString *key = [[[BBCalendarService sharedService] dateFormatter] stringFromDate:date];
  return [self.eventsByDate objectForKey:key];
}

#pragma mark - DatesSelected Methods

- (BOOL)isInDatesSelected:(NSDate *)date {
  for (NSDate *dateSelected in self.datesSelected) {
    if ([self.calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]) {
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
  NSArray *sortedArray = [self.datesSelected sortedArrayUsingComparator:^(NSDate *d1, NSDate *d2) {
    return [d1 compare:d2];
  }];
  self.datesSelected = [NSMutableArray arrayWithArray:sortedArray];
  if ([self.delegate respondsToSelector:@selector(currentArraySelectionDays:)]) {
    [self.delegate currentArraySelectionDays:self.datesSelected];
  }
}

- (void)_setTextInLabel {
  self.informationLabel.text = [NSString stringWithFormat:@"Выбрано %lu дней из %ld", (unsigned long) [self.datesSelected count], (long) self.countDayInOrder];
}

#pragma mark - Lazy Load

- (JTCalendarManager *)calendarManager {
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
