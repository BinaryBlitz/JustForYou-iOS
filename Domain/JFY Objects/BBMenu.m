//
//  BBMenu.m
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMenu.h"

typedef enum : NSInteger {
    BBStartSegment,
    BBEndSegment
}BBPieceSegment;

@implementation BBMenu


- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.menuId = [[JSONObj objectForKey:@"id"] integerValue];
        self.content = [JSONObj objectForKey:@"content"];
        self.weight = [[JSONObj objectForKey:@"weight"] integerValue];
        self.calories = [[JSONObj objectForKey:@"calories"] integerValue];
        [self _createDateWithString:[JSONObj objectForKey:@"starts_at"] keySegment:BBStartSegment];
        [self _createDateWithString:[JSONObj objectForKey:@"ends_at"] keySegment:BBEndSegment];
    }
    return self;
}

-(void)_createDateWithString:(NSString *)dateString keySegment:(BBPieceSegment)segment {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    NSDate *date = [formatter dateFromString:dateString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if (segment == BBStartSegment) {
        self.startsHour = hour;
        self.startsMinute = minute;
    } else {
        self.endsHour = hour;
        self.endsMinute = minute;
    }
}

@end
