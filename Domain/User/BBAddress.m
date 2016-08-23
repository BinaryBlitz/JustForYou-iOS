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
NSString* const kStreet = @"kStreet";
NSString* const kHouse = @"kHouse";
NSString* const kApartment = @"kApartment";
NSString* const kFloor = @"kFloor";
NSString* const kEntrance = @"kEntrance";
NSString* const kAddressId = @"kAddressId";

@implementation BBAddress

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.addressId = [[JSONObj valueForKey:@"id"] integerValue];
        self.country = @"Россия";
        self.city = @"Москва";
        self.street = [JSONObj valueForKey:@"content"];
        id object = [JSONObj valueForKey:@"house"];
        if (object && object != (id)[NSNull null]) {
            self.house = [object integerValue];
        }
        object = [JSONObj valueForKey:@"apartment"];
        if (object && object != (id)[NSNull null]) {
            self.apartment = [object integerValue];
        }
        object = [JSONObj valueForKey:@"floor"];
        if (object && object != (id)[NSNull null]) {
            self.floor = [object integerValue];
        }
        object = [JSONObj valueForKey:@"entrance"];
        if (object && object != (id)[NSNull null]) {
            self.entrance = [object integerValue];
        }
        double lat = [[JSONObj valueForKey:@"latitude"] doubleValue];
        double lng = [[JSONObj valueForKey:@"longitude"] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate country:(NSString *)country city:(NSString *)city street:(NSString *)street house:(NSString *)house {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.city = city;
        self.country = country;
        self.street = street;
        if (house) {
            self.house = [house integerValue];
        }
    }
    return self;
}

- (NSString *)formatedDescription {
    return [NSString  stringWithFormat:@"%@ %ld", self.street, (long)self.house];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        double lat = [coder decodeDoubleForKey:kLatitudeCoordinate];
        double lng = [coder decodeDoubleForKey:kLongitudeCoordinate];
        self.coordinate = CLLocationCoordinate2DMake(lat, lng);
        self.country = [coder decodeObjectForKey:kCountry];
        self.city = [coder decodeObjectForKey:kCity];
        self.street = [coder decodeObjectForKey:kStreet];
        self.house = [coder decodeIntegerForKey:kHouse];
        self.apartment = [coder decodeIntegerForKey:kApartment];
        self.floor = [coder decodeIntegerForKey:kFloor];
        self.entrance = [coder decodeIntegerForKey:kEntrance];
        self.addressId = [coder decodeIntegerForKey:kAddressId];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.coordinate.latitude forKey:kLatitudeCoordinate];
    [aCoder encodeDouble:self.coordinate.longitude forKey:kLongitudeCoordinate];
    [aCoder encodeObject:self.country forKey:kCountry];
    [aCoder encodeObject:self.city forKey:kCity];
    [aCoder encodeObject:self.street forKey:kStreet];
    [aCoder encodeInteger:self.house forKey:kHouse];
    [aCoder encodeInteger:self.apartment forKey:kApartment];
    [aCoder encodeInteger:self.floor forKey:kFloor];
    [aCoder encodeInteger:self.entrance forKey:kEntrance];
    [aCoder encodeInteger:self.addressId forKey:kAddressId];
}

@end
