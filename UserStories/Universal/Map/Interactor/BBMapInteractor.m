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

@interface BBMapInteractor ()

@property (strong, nonatomic) BBAddress *currentAddres;

@end

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
                                                self.currentAddres = adr;
                                            }
                                        }];

}

- (void)currentLocation {
    if (!self.currentAddres) {
        INTULocationManager *locationManager = [INTULocationManager sharedInstance];
        INTULocationRequestID requestID = [locationManager subscribeToLocationUpdatesWithDesiredAccuracy:INTULocationAccuracyBlock
                                                                 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                                     if (status == INTULocationStatusSuccess) {
                                                                         [self.output currentLocationWithLocation:currentLocation.coordinate];
                                                                         [locationManager cancelHeadingRequest:requestID];
                                                                     } else if (status == INTULocationStatusTimedOut) {
                                                                         [self currentLocation];
                                                                     }
                                                                 }];
    }
}

- (void)searchGeopositionForAddress:(NSString *)searchText {
    [[BBAddressService sharedService] searchGeopositionForAddress:searchText completion:^(NSArray *array) {
        if (array) {
            [self.output searchAddressInArray:array];
        }
    }];
}

@end