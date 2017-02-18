//
//  BBUser.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBUser.h"

NSString* const kEmail = @"kEmail";
NSString* const kUserName = @"kUserName";
NSString* const kUserSurname = @"kUserSurname";
NSString* const kUserId = @"kUserId";
NSString* const kNumberPhone = @"kNumberPhone";
NSString* const kOrdersProgramArray = @"kOrdersProgramArray";
NSString* const kAddressArray = @"kAddressArray";
NSString* const kBalance = @"kBalance";
NSString* const kEnableBonuses = @"kEnableBonuses";
NSString* const kCountPurchases = @"kCountPurchases";

@implementation BBUser

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.userId = [[JSONObj valueForKey:@"id"] integerValue];
        self.email = [JSONObj valueForKey:@"email"];
        self.name = [JSONObj valueForKey:@"first_name"];
        self.surname = [JSONObj valueForKey:@"last_name"];
        self.numberPhone = [JSONObj valueForKey:@"phone_number"];
        self.balance = [[JSONObj valueForKey:@"balance"] integerValue];
        self.countPurchases = 0;
        self.addressArray = [NSArray array];
        self.ordersProgramArray = [NSArray array];
        self.enableBonuses = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.email = [coder decodeObjectForKey:kEmail];
        self.name = [coder decodeObjectForKey:kUserName];
        self.surname = [coder decodeObjectForKey:kUserSurname];
        self.numberPhone = [coder decodeObjectForKey:kNumberPhone];
        self.userId = [coder decodeIntegerForKey:kUserId];
        self.ordersProgramArray = [coder decodeObjectForKey:kOrdersProgramArray];
        self.addressArray = [coder decodeObjectForKey:kAddressArray];
        self.balance = [coder decodeIntegerForKey:kBalance];
        self.enableBonuses = [coder decodeBoolForKey:kEnableBonuses];
        self.countPurchases = [coder decodeIntegerForKey:kCountPurchases];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.email forKey:kEmail];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.surname forKey:kUserSurname];
    [aCoder encodeObject:self.numberPhone forKey:kNumberPhone];
    [aCoder encodeInteger:self.userId forKey:kUserId];
    [aCoder encodeObject:self.ordersProgramArray forKey:kOrdersProgramArray];
    [aCoder encodeObject:self.addressArray forKey:kAddressArray];
    [aCoder encodeInteger:self.balance forKey:kBalance];
    [aCoder encodeBool:self.enableBonuses forKey:kEnableBonuses];
    [aCoder encodeInteger:self.countPurchases forKey:kCountPurchases];
}


@end
