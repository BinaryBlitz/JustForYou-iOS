//
//  BBMapInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBMapInteractorOutput <NSObject>

- (void)currentAddresByCoordinate:(BBAddress *)address;

- (void)currentLocationWithLocation:(CLLocationCoordinate2D)coordinate;

- (void)searchAddressInArray:(NSArray *)arrayAddress;

- (void)errorNetwork;
- (void)errorServer;


@end
