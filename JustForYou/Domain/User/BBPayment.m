//
//  BBPayment.m
//  JustForYou
//
//  Created by Антон on 15.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPayment.h"

@implementation BBPayment

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.paymentId = [[JSONObj valueForKey:@"id"] integerValue];
        self.paymentURL = [JSONObj valueForKey:@"payment_url"];
    }
    return self;
}

@end
