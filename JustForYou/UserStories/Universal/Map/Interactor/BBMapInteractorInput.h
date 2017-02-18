#import <Foundation/Foundation.h>

@import GoogleMaps;

@protocol BBMapInteractorInput <NSObject>

- (void)mapViewIdleAtCameraPosition:(GMSCameraPosition *)position;

- (void)currentLocation;

- (void)searchGeopositionForAddress:(NSString *)searchText;

- (BBAddress *)currentInteractorAddress;

@end
