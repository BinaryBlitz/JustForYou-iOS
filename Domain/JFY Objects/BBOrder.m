//
//  BBOrder.m
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBOrder.h"

@implementation BBOrder

+ (NSArray *)ignoredProperties {
    return @[@"colorProgram"];
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"programId" : @1};
}

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.programId = [[JSONObj objectForKey:@"id"] integerValue];
        self.scheduledDay = [self dateForString:[JSONObj objectForKey:@"scheduled_for"]];
        self.colorProgram = [BBConstantAndColor colorForIdBlock:self.programId];
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

@end
