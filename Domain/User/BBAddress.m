//
//  BBAddress.m
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddress.h"

@implementation BBAddress

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate country:(NSString *)country city:(NSString *)city address:(NSString *)address {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.city = city;
        self.country = country;
        self.address = address;
    }
    return self;
}

- (NSString *)formatedDescription {
    return [NSString  stringWithFormat:@"%@", self.address];
}

@end
