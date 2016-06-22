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
        self.blockId = [[JSONObj valueForKey:@"id"] integerValue];
        self.name = [JSONObj valueForKey:@"name"];
        self.image = [JSONObj valueForKey:@"image_url"];
        self.programs_count = [[JSONObj valueForKey:@"programs_count"] integerValue];
    }
    return self;
}




@end
