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

@implementation BBUser

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.userId = [[JSONObj valueForKey:@"id"] integerValue];
        self.email = [JSONObj valueForKey:@"email"];
        self.name = [JSONObj valueForKey:@"first_name"];
        self.surname = [JSONObj valueForKey:@"last_name"];
        self.numberPhone = [JSONObj valueForKey:@"phone_number"];
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
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.email forKey:kEmail];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.surname forKey:kUserSurname];
    [aCoder encodeObject:self.numberPhone forKey:kNumberPhone];
    [aCoder encodeInteger:self.userId forKey:kUserId];
}


@end
