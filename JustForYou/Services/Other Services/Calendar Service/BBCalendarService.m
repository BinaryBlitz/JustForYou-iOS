#import "BBCalendarService.h"

@interface BBCalendarService ()

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation BBCalendarService

+ (instancetype)sharedService {
  static BBCalendarService *service = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    service = [[BBCalendarService alloc] init];
  });
  return service;
}

- (NSDate *)dateForString:(NSString *)dateString {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
  NSLocale *posix = [NSLocale systemLocale];//[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  [formatter setLocale:posix];
  NSDate *date = [formatter dateFromString:dateString];
  return date;
}

- (NSString *)stringForDate:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  return [formatter stringFromDate:date];
}

- (NSString *)stringWithDateForDate:(NSDate *)date {
  NSString *result = @"";
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
  NSInteger year = [components year];
  NSInteger month = [components month];
  NSInteger day = [components day];

  NSString *dayS;
  NSString *monthS;
  NSDate *today = [NSDate date];
  NSDateComponents *componentsToday = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
  NSInteger yearT = [componentsToday year];
  NSInteger monthT = [componentsToday month];
  NSInteger dayT = [componentsToday day];
  if ((year == yearT) && (month == monthT)) {
    if (day + 1 == dayT) {
      result = @"Вчера";
    } else if (day + 2 == dayT) {
      result = @"Позавчера";
    } else {
      if (day < 10) {
        dayS = [NSString stringWithFormat:@"0%ld", (long) day];
      } else {
        dayS = [NSString stringWithFormat:@"%ld", (long) day];
      }
      if (month < 10) {
        monthS = [NSString stringWithFormat:@"0%ld", (long) month];
      } else {
        monthS = [NSString stringWithFormat:@"%ld", (long) month];
      }
      result = [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long) year];
    }
  } else {
    if (day < 10) {
      dayS = [NSString stringWithFormat:@"0%ld", (long) day];
    } else {
      dayS = [NSString stringWithFormat:@"%ld", (long) day];
    }
    if (month < 10) {
      monthS = [NSString stringWithFormat:@"0%ld", (long) month];
    } else {
      monthS = [NSString stringWithFormat:@"%ld", (long) month];
    }
    result = [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long) year];
  }
  return result;
}

- (NSString *)dateForUIWithDate:(NSDate *)date {
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
  NSInteger day = [components day];
  NSInteger month = [components month];
  NSInteger year = [components year];
  NSString *dayS = @"";
  NSString *monthS = @"";
  if (day < 10) {
    dayS = [NSString stringWithFormat:@"0%ld", (long) day];
  } else {
    dayS = [NSString stringWithFormat:@"%ld", (long) day];
  }

  if (month < 10) {
    monthS = [NSString stringWithFormat:@"0%ld", (long) month];
  } else {
    monthS = [NSString stringWithFormat:@"%ld", (long) month];
  }

  return [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long) year];
}


- (NSInteger)getCalendarDay:(NSDate *)date {
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
  return [components day];
}

- (NSInteger)getCalendarMonth:(NSDate *)date {
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
  return [components month];
}

- (NSInteger)getCalendarYear:(NSDate *)date {
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
  return [components year];
}

- (BOOL)compareTwoDatesWithDay:(NSDate *)date {
  return ([date timeIntervalSinceNow] > 0);
}

- (BBStatusOrderTime)timeForDate:(NSDate *)date {
  if ([date timeIntervalSinceNow] < 0) {
    return BBStatusPassedTime;
  }
  NSDate *today = [NSDate date];
  NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:today];
  double secondsInAnHour = 3600;
  NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
  if (hoursBetweenDates <= 36) {
    return BBstatusTodayTime;
  }
  return BBStatusFutureTime;
}

- (NSMutableDictionary *)updateEventsByDateForOrders:(NSArray *)ordersForCalendar events:(NSMutableDictionary *)eventsByDate {
  eventsByDate = [NSMutableDictionary dictionary];
  for (BBOrder *order in ordersForCalendar) {
    NSDate *date = order.scheduledDay;
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if (!eventsByDate[key]) {
      NSMutableArray *programs = [NSMutableArray array];
      [programs addObject:order];
      [eventsByDate setObject:programs forKey:key];
    } else {
      NSMutableArray *prog = [eventsByDate objectForKey:key];
      [prog addObject:order];
      [eventsByDate setObject:prog forKey:key];
    }
  }
  return eventsByDate;
}

- (NSDate *)addTimeForDate:(NSDate *)date hour:(NSInteger)hour minute:(NSInteger)minute {
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setMinute:minute];
  [components setHour:hour];
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  date = [calendar dateByAddingComponents:components toDate:date options:0];
  return date;
}

- (NSDateFormatter *)dateFormatter {
  static NSDateFormatter *dateFormatter;
  if (!dateFormatter) {
    dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
  }
  return dateFormatter;
}

@end
