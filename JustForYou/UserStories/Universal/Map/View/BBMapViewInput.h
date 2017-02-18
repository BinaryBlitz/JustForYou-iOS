#import <Foundation/Foundation.h>

@import GoogleMaps;

@protocol BBMapViewInput <NSObject>

- (void)setupInitialState;

- (void)moveCameraToCoordinateWithMyLocation;

- (void)moveCameraToCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)updateTextFieldAddressWithAddress:(BBAddress *)address;

- (void)presentSearchController;

- (void)updateResultSearchControllerWithArray:(NSArray *)arrayAddress;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;


@end
