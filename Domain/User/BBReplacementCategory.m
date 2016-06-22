//
//  BBReplacementCategory.m
//  JustForYou
//
//  Created by Антон on 20.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBReplacementCategory.h"

@implementation BBReplacementCategory

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.categoryId = [[JSONObj valueForKey:@"id"] integerValue];
        self.nameCategory = [JSONObj valueForKey:@"name"];
        self.products = [self parseProductsWithJSON:[JSONObj valueForKey:@"products"]];
    }
    return self;
}

- (NSArray *)parseProductsWithJSON:(id)JSONObj {
    NSMutableArray *products = [NSMutableArray array];
    if ([JSONObj isKindOfClass:[NSArray class]]) {
        for (id obj in JSONObj) {
            BBReplacementProduct *product = [[BBReplacementProduct alloc] initWithJSON:obj];
            [products addObject:product];
        }
    }
    return products;
}

@end

