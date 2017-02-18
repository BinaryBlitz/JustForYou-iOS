#import <Foundation/Foundation.h>

#import <JTCalendar/JTCalendar.h>

typedef enum : NSUInteger {
    BBStatusPassedTime,
    BBstatusTodayTime,
    BBStatusFutureTime
}BBStatusOrderTime;

@interface BBCalendarService : NSObject

+ (instancetype) sharedService;

- (NSDate *)dateForString:(NSString *)dateString;

- (NSString *)stringForDate:(NSDate *)date;
- (NSString *)stringWithDateForDate:(NSDate *)date;
- (NSString *)dateForUIWithDate:(NSDate *)date;
- (NSDate *)addTimeForDate:(NSDate *)date hour:(NSInteger)hour minute:(NSInteger)minute;

- (NSMutableDictionary *)updateEventsByDateForOrders:(NSArray *)ordersForCalendar events:(NSMutableDictionary *)eventsByDate;
- (NSDateFormatter *)dateFormatter;

- (BOOL)compareTwoDatesWithDay:(NSDate *)date;

- (BBStatusOrderTime)timeForDate:(NSDate *)date;

@end
