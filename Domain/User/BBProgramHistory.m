//
//  BBProgramHistory.m
//  JustForYou
//
//  Created by Антон on 25.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBProgramHistory.h"

#import "BBCalendarService.h"

@implementation BBProgramHistory

- (instancetype)initWithJSON:(id)JSONObj program:(id)program {
    self = [super init];
    if (self) {
        self.historyId = [[JSONObj valueForKey:@"id"] integerValue];
        self.totalPrice = [[JSONObj valueForKey:@"total_price"] integerValue];
        self.dateCreate = [[BBCalendarService sharedService] dateForString:[JSONObj valueForKey:@"created_at"]];
        self.nameProgram = [program valueForKey:@"name"];
        self.elementBlock = [[BBElementBlock alloc] initWithBlockId:[[program valueForKey:@"block_id"] integerValue]];
    }
    return self;
}

@end
