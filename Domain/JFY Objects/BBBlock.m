//
//  BBBlock.m
//  JustForYou
//
//  Created by Антон on 09.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBBlock.h"

#import "BBProgram.h"

@implementation BBBlock

+ (NSString *)primaryKey {
    return @"blockId";
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"programs": [RLMPropertyDescriptor descriptorWithClass:BBProgram.class propertyName:@"block"],
             };
}

- (instancetype)initWithJSON:(id)JSONObj andUrlServer:(NSString *)url {
    self = [super init];
    if (self) {
        self.blockId = [[JSONObj objectForKey:@"id"] integerValue];
        self.name = [JSONObj objectForKey:@"name"];
        self.image = [JSONObj objectForKey:@"image_url"];
        self.programs_count = [[JSONObj objectForKey:@"programs_count"] integerValue];
    }
    return self;
}




@end
