//
//  BBMapInteractor.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapInteractor.h"

#import "BBMapInteractorOutput.h"

#import <LMGeocoder.h>

#import "BBAddressService.h"

#import <INTULocationManager.h>

@implementation BBMapInteractor

#pragma mark - Методы BBMapInteractorInput

- (void)mapViewIdleAtCameraPosition:(GMSCameraPosition *)position {
    [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:position.target
                                                  service:kLMGeocoderGoogleService
                                        completionHandler:^(NSArray *results, NSError *error) {
                                            if (results.count && !error) {
                                                
                                                LMAddress *address = [results firstObject];
                                                BBAddress *adr = [[BBAddressService sharedService] addressFromAddress:address];
                                                [self.output currentAddresByCoordinate:adr];
                                                
                                            }
                                        }];

}

- (void)currentLocation {
    [[INTULocationManager sharedInstance] subscribeToLocationUpdatesWithDesiredAccuracy:INTULocationAccuracyBlock
                                                                                  block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                                                      if (status == INTULocationStatusSuccess) {
                                                                                          [self.output currentLocationWithLocation:currentLocation.coordinate];
                                                                                      } else if (status == INTULocationStatusTimedOut) {
                                                                                          [self currentLocation];
                                                                                      }
                                                                                  }];
}

- (void)searchGeopositionForAddress:(NSString *)searchText {
    [[BBAddressService sharedService] searchGeopositionForAddress:searchText completion:^(NSArray *array) {
        if (array) {
            [self.output searchAddressInArray:array];
        }
    }];
}

@end