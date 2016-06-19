//
//  BBAddress.h
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface BBAddress : NSObject

@property (assign, nonatomic) NSInteger addressId;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;

-(instancetype)initWithJSON:(id)JSONObj;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate country:(NSString *)country city:(NSString *)city address:(NSString *)address;

- (NSString *)formatedDescription;

@end
