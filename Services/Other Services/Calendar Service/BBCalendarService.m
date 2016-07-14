//
//  BBCalendarService.m
//  JustForYou
//
//  Created by Антон on 19.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarService.h"

@interface BBCalendarService()

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation BBCalendarService

+ (instancetype) sharedService {
    static BBCalendarService* service = nil;
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
    return [formatter stringFromDate:date];;
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
        if (day+1 == dayT) {
            result = @"Вчера";
        } else if (day+2 == dayT) {
            result = @"Позавчера";
        } else {
            if (day < 10) {
                dayS = [NSString stringWithFormat:@"0%ld", (long)day];
            } else {
                dayS = [NSString stringWithFormat:@"%ld", (long)day];
            }
            if (month < 10) {
                monthS = [NSString stringWithFormat:@"0%ld", (long)month];
            } else {
                monthS = [NSString stringWithFormat:@"%ld", (long)month];
            }
            result = [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long)year];
        }
    } else {
        if (day < 10) {
            dayS = [NSString stringWithFormat:@"0%ld", (long)day];
        } else {
            dayS = [NSString stringWithFormat:@"%ld", (long)day];
        }
        if (month < 10) {
            monthS = [NSString stringWithFormat:@"0%ld", (long)month];
        } else {
            monthS = [NSString stringWithFormat:@"%ld", (long)month];
        }
        result = [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long)year];
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
    NSString *dayS= @"";
    NSString *monthS= @"";
    if (day < 10) {
        dayS = [NSString stringWithFormat:@"0%ld", (long)day];
    } else {
        dayS = [NSString stringWithFormat:@"%ld", (long)day];
    }
    
    if (month < 10) {
        monthS = [NSString stringWithFormat:@"0%ld", (long)month];
    } else {
        monthS = [NSString stringWithFormat:@"%ld", (long)month];
    }
    
    return [NSString stringWithFormat:@"%@.%@.%ld", dayS, monthS, (long)year];
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

@end