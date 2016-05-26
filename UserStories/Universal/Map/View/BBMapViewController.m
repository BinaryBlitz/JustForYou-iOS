//
//  BBMapViewController.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapViewController.h"

#import "BBMapViewOutput.h"

#import "BBTextField.h"

#import <LMGeocoder.h>

#import "BBAddressService.h"

@import GoogleMaps;


@interface BBMapViewController() <GMSMapViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet BBTextField *addressTextField;

@property (strong, nonatomic) UIBarButtonItem *myLocationButton;

@end

@implementation BBMapViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [self _layoutAddressTextField];
}

#pragma mark - Actions Methods

- (void)_myLocationButtonAction {
     [self moveCameraToCoordinate:self.mapView.myLocation.coordinate];
}

#pragma mark - Методы BBMapViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleMapModule;
    self.navigationItem.rightBarButtonItem = self.myLocationButton;
    self.addressTextField.delegate = self;
    [self _settingMapView];
}

- (void)_settingMapView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.75708318
                                                            longitude:37.60244361
                                                                 zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
}

- (void)moveCameraToCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                            longitude:coordinate.longitude
                                                                 zoom:17];
    
    [self.mapView animateToCameraPosition:camera];
}

#warning delte this code

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
//    if (self.needUpdate) {
        [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:position.target
                                                      service:kLMGeocoderGoogleService
                                            completionHandler:^(NSArray *results, NSError *error) {
                                                if (results.count && !error) {
                                                    LMAddress *address = [results firstObject];
                                                    
                                                    BBAddress *adr = [BBAddressService addressFromAddress:address];
                                                    
                                                    self.addressTextField.text = [adr formatedDescription];
                                                    
//                                                    self.selectedAddress = adr;
                                                }
                                            }];
//    } else {
//        self.needUpdate = YES;
//    }
}

#pragma mark - Layout Methods

- (void)_layoutAddressTextField {
    self.addressTextField.layer.masksToBounds = YES;
    self.addressTextField.layer.cornerRadius = 5.0f;
}

#pragma mark - Lazy Load

- (UIBarButtonItem *)myLocationButton {
    if (!_myLocationButton) {
        _myLocationButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"myLocationIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_myLocationButtonAction)];
    }
    return _myLocationButton;
}

@end