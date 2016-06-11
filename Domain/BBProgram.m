//
//  BBProgram.m
//  JustForYou
//
//  Created by Антон on 11.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBProgram.h"

@implementation BBProgram



+ (NSArray *)ignoredProperties {
    return @[@"parentId"];
}

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.programId = [[JSONObj objectForKey:@"id"] integerValue];
        self.name = [JSONObj objectForKey:@"name"];
        self.descript = [JSONObj objectForKey:@"description"];
        self.threshold = [[JSONObj objectForKey:@"threshold"] integerValue];
        self.primaryPrice = [[JSONObj objectForKey:@"primary_price"] integerValue];
        self.secondaryPrice = [[JSONObj objectForKey:@"secondary_price"] integerValue];
        self.previewImage = [JSONObj objectForKey:@"preview_image_url"];
    }
    return self;
}


@end
