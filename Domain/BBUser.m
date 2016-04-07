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

@implementation BBUser

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.email = [JSONObj valueForKey:@"email"];
        self.name = [JSONObj valueForKey:@"name"];
        self.surname = [JSONObj valueForKey:@"surname"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.email = [coder decodeObjectForKey:kEmail];
        self.name = [coder decodeObjectForKey:kUserName];
        self.surname = [coder decodeObjectForKey:kUserSurname];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.email forKey:kEmail];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.surname forKey:kUserSurname];
}


@end
