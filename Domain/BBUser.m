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
NSString* const kUserSubname = @"kUserSubname";

@implementation BBUser

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.email = [JSONObj valueForKey:@"email"];
        self.name = [JSONObj valueForKey:@"name"];
        self.subname = [JSONObj valueForKey:@"subname"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.email = [coder decodeObjectForKey:kEmail];
        self.name = [coder decodeObjectForKey:kUserName];
        self.subname = [coder decodeObjectForKey:kUserSubname];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.email forKey:kEmail];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.subname forKey:kUserSubname];
}


@end
