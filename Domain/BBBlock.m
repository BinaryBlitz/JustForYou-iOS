//
//  BBBlock.m
//  JustForYou
//
//  Created by Антон on 08.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBBlock.h"

@implementation BBBlock

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.blockId = [[JSONObj objectForKey:@"id"] integerValue];
        self.name = [JSONObj objectForKey:@"name"];
        self.image = [[[JSONObj objectForKey:@"image"] objectForKey:@"image"] objectForKey:@"url"];
    }
    return self;
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
