//
//  BBExchange.m
//  JustForYou
//
//  Created by Антон on 30.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBExchange.h"

@implementation BBExchange

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.exchangeId = [[JSONObj valueForKey:@"id"] integerValue];
        self.programId = [[JSONObj valueForKey:@"program_id"] integerValue];
        self.purchaseId = [[JSONObj valueForKey:@"purchase_id"] integerValue];
        self.pengingBalanse = [[JSONObj valueForKey:@"pending_balance"] integerValue];
        self.paid = [[JSONObj valueForKey:@"paid"] boolValue];
    }
    return self;
}

@end
