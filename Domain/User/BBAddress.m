//
//  BBAddress.m
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddress.h"

NSString* const kLatitudeCoordinate = @"kLatitudeCoordinate";
NSString* const kLongitudeCoordinate = @"kLongitudeCoordinate";
NSString* const kCountry = @"kCountry";
NSString* const kCity = @"kCity";
NSString* const kAddress = @"kAddress";

@implementation BBAddress

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.addressId = [[JSONObj objectForKey:@"id"] integerValue];
        self.address = [JSONObj objectForKey:@"content"];
        self.country = @"Россия";
        self.city = @"Москва";
        double lat = 3;
        double lng = 3;
        self.coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}

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

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        double lat = [coder decodeDoubleForKey:kLatitudeCoordinate];
        double lng = [coder decodeDoubleForKey:kLongitudeCoordinate];
        self.coordinate = CLLocationCoordinate2DMake(lat, lng);
        self.country = [coder decodeObjectForKey:kCountry];
        self.city = [coder decodeObjectForKey:kCity];
        self.address = [coder decodeObjectForKey:kAddress];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.coordinate.latitude forKey:kLatitudeCoordinate];
    [aCoder encodeDouble:self.coordinate.longitude forKey:kLongitudeCoordinate];
    [aCoder encodeObject:self.country forKey:kCountry];
    [aCoder encodeObject:self.city forKey:kCity];
    [aCoder encodeObject:self.address forKey:kAddress];
}

@end
