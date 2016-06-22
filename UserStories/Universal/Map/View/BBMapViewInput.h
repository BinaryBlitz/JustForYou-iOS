//
//  BBMapViewInput.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

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