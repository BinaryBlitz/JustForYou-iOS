//
//  BBPayCard.m
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPayCard.h"

@implementation BBPayCard

+ (NSString *)primaryKey {
    return @"payCardId";
}

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.payCardId = [[JSONObj objectForKey:@"id"] integerValue];
        self.holder = [JSONObj objectForKey:@"holder"];
        self.number = [JSONObj objectForKey:@"number"];
    }
    return self;
}

@end
