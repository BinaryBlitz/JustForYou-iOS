//
//  BBStock.m
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBStock.h"

@implementation BBStock

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.stockId = [[JSONObj objectForKey:@"id"] integerValue];
        self.name = [JSONObj objectForKey:@"name"];
        self.descript = [JSONObj objectForKey:@"description"];
        self.date = [self dateForString:[JSONObj objectForKey:@"created_at"]];
    }
    return self;
}

- (NSDate *)dateForString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [NSLocale systemLocale];//[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

- (NSString *)dateForUI {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
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

@end
