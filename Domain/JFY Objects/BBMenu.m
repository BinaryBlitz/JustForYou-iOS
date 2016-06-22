//
//  BBMenu.m
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMenu.h"

#import "BBCalendarService.h"

typedef enum : NSInteger {
    BBStartSegment,
    BBEndSegment
}BBPieceSegment;

@implementation BBMenu


- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.menuId = [[JSONObj valueForKey:@"id"] integerValue];
        self.content = [JSONObj valueForKey:@"content"];
        self.weight = [[JSONObj valueForKey:@"weight"] integerValue];
        self.calories = [[JSONObj valueForKey:@"calories"] integerValue];
        [self _createDateWithString:[JSONObj valueForKey:@"starts_at"] keySegment:BBStartSegment];
        [self _createDateWithString:[JSONObj valueForKey:@"ends_at"] keySegment:BBEndSegment];
    }
    return self;
}

-(void)_createDateWithString:(NSString *)dateString keySegment:(BBPieceSegment)segment {
    NSDate *date = [[BBCalendarService sharedService] dateForString:dateString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
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
