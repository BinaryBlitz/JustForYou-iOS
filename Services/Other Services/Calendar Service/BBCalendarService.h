//
//  BBCalendarService.h
//  JustForYou
//
//  Created by Антон on 19.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JTCalendar/JTCalendar.h>

@interface BBCalendarService : NSObject

+ (instancetype) sharedService;

- (NSDate *)dateForString:(NSString *)dateString;

- (NSString *)stringForDate:(NSDate *)date;
- (NSString *)stringWithDateForDate:(NSDate *)date;

- (BOOL)compareTwoDatesWithDay:(NSDate *)date;

@end
