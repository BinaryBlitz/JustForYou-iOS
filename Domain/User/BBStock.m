//
//  BBStock.m
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBStock.h"

#import "BBCalendarService.h"

@implementation BBStock

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.stockId = [[JSONObj valueForKey:@"id"] integerValue];
        self.name = [JSONObj valueForKey:@"name"];
        self.descript = [JSONObj valueForKey:@"description"];
        self.date = [[BBCalendarService sharedService] dateForString:[JSONObj valueForKey:@"created_at"]];
    }
    return self;
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
