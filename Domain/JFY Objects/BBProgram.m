//
//  BBProgram.m
//  JustForYou
//
//  Created by Антон on 11.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBProgram.h"

#import "BBDay.h"

@implementation BBProgram

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"days": [RLMPropertyDescriptor descriptorWithClass:BBDay.class propertyName:@"program"],
             };
}

+ (NSString *)primaryKey {
    return @"programId";
}

+ (NSArray *)ignoredProperties {
    return @[@"parentId"];
}

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.programId = [[JSONObj valueForKey:@"id"] integerValue];
        self.name = [JSONObj valueForKey:@"name"];
        self.descript = [JSONObj valueForKey:@"description"];
        self.shortDescript = [JSONObj valueForKey:@"preview"];
        self.threshold = [[JSONObj valueForKey:@"threshold"] integerValue];
        self.primaryPrice = [[JSONObj valueForKey:@"primary_price"] integerValue];
        self.secondaryPrice = [[JSONObj valueForKey:@"secondary_price"] integerValue];
        self.previewImage = [JSONObj valueForKey:@"preview_image_url"];
        [self _initPrescriptionArrayWithJSON:[JSONObj valueForKey:@"prescription"]];
    }
    return self;
}

- (void)_initPrescriptionArrayWithJSON:(id)JSONArray {
    if (JSONArray && [JSONArray isKindOfClass:[NSArray class]]) {
        if (JSONArray[0]) {
            self.firstPrescription = JSONArray[0];
        }
        if (JSONArray[1]) {
            self.secondPrescription = JSONArray[1];
        }
        if (JSONArray[2]) {
            self.thirdPrescription = JSONArray[2];
        }
    }
}

@end
