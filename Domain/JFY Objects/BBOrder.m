//
//  BBOrder.m
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBOrder.h"

#import "BBCalendarService.h"

@implementation BBOrder

+ (NSArray *)ignoredProperties {
    return @[@"colorProgram"];
}


- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.orderId = [[JSONObj valueForKey:@"id"] integerValue];
        self.scheduledDay = [[BBCalendarService sharedService] dateForString:[JSONObj valueForKey:@"scheduled_for"]];
//        self.colorProgram = [BBConstantAndColor colorForIdBlock:self.programId];
        self.commentOrder = [JSONObj valueForKey:@"comment"];
    }
    return self;
}


@end
