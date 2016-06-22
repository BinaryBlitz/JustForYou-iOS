//
//  BBReplacementProduct.m
//  JustForYou
//
//  Created by Антон on 20.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBReplacementProduct.h"

NSString* const kName = @"kName";
NSString* const kPorouctId = @"kPorouctId";

@implementation BBReplacementProduct

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.productId = [[JSONObj valueForKey:@"id"] integerValue];
        self.nameProduct = [JSONObj valueForKey:@"name"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.nameProduct = [coder decodeObjectForKey:kName];
        self.productId = [coder decodeIntegerForKey:kPorouctId];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.productId forKey:kPorouctId];
    [aCoder encodeObject:self.nameProduct forKey:kName];
}

@end
