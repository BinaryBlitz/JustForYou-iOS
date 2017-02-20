#import <Foundation/Foundation.h>

@protocol BBMapInteractorOutput <NSObject>

- (void)currentAddresByCoordinate:(BBAddress *)address;

- (void)currentLocationWithLocation:(CLLocationCoordinate2D)coordinate;

- (void)searchAddressInArray:(NSArray *)arrayAddress;

- (void)errorNetwork;
- (void)errorServer;


@end
