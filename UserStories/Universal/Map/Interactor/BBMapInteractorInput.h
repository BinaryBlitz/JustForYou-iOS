//
//  BBMapInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMaps;

@protocol BBMapInteractorInput <NSObject>

- (void)mapViewIdleAtCameraPosition:(GMSCameraPosition *)position;

- (void)currentLocation;

- (void)searchGeopositionForAddress:(NSString *)searchText;

- (void)addAddressToUserAddressArrayWithAddressText:(NSString *)addressText;

@end
