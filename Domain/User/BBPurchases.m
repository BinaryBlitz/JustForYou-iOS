//
//  BBPurchases.m
//  JustForYou
//
//  Created by Антон on 21.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPurchases.h"

@implementation BBPurchases

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.purchasesId = [[JSONObj valueForKey:@"id"] integerValue];
        self.numberDays = [[JSONObj valueForKey:@"number_of_days"] integerValue];
        [self initProgramOptionsWithPorgram:[JSONObj objectForKey:@"program"]];
    }
    return self;
}

- (void)initProgramOptionsWithPorgram:(id)prog {
    self.programId = [[prog valueForKey:@"id"] integerValue];
    self.nameProgram = [prog valueForKey:@"name"];
    self.elementBlock = [[BBElementBlock alloc] initWithProgramId:self.programId];
}

@end
