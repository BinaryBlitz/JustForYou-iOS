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

@end
