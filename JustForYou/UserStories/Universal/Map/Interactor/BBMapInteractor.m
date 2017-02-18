#import "BBMapInteractor.h"

#import "BBMapInteractorOutput.h"

#import <LMGeocoder.h>
#import <INTULocationManager.h>

#import "BBAddressService.h"
#import "BBUserService.h"
#import "BBServerService.h"

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
        [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock
                                                   timeout:1.0
                                      delayUntilAuthorized:YES
                                                     block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                         if (status == INTULocationStatusSuccess) {
                                                             [self.output currentLocationWithLocation:currentLocation.coordinate];
                                                         } else if (status == INTULocationStatusTimedOut) {
                                                             [self currentLocation];
                                                         } else {
                                                             // An error occurred, more info is available by
                                                             // looking at the specific status returned.
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

- (BBAddress *)currentInteractorAddress {
    return self.currentAddres;
}

@end
