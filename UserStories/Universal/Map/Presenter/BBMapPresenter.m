//
//  BBMapPresenter.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapPresenter.h"

#import "BBMapViewInput.h"
#import "BBMapInteractorInput.h"
#import "BBMapRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBMapPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBMapPresenter

#pragma mark - Методы BBMapModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)viewWillAppear {
    [self.interactor currentLocation];
}

- (void)myLocationButtonDidTap {
    [self.view moveCameraToCoordinateWithMyLocation];
}

- (void)addButtonDidTap {
    
}

- (void)textFieldDidBeginEditing {
    [self.view presentSearchController];
}

- (void)mapViewIdleAtCameraPosition:(GMSCameraPosition *)position {
    [self.interactor mapViewIdleAtCameraPosition:position];
}

- (void)updateSearchResultsWithText:(NSString *)searchText {
    if (!searchText || searchText.length < 3) {
        return;
    }
    [self.interactor searchGeopositionForAddress:searchText];
}

#pragma mark - Методы BBMapViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBMapInteractorOutput

- (void)currentAddresByCoordinate:(BBAddress *)address {
    [self.view updateTextFieldAddressWithAddress:address];
}

- (void)currentLocationWithLocation:(CLLocationCoordinate2D)coordinate {
    [self.view moveCameraToCoordinate:coordinate];
}

- (void)searchAddressInArray:(NSArray *)arrayAddress {
    [self.view updateResultSearchControllerWithArray:arrayAddress];
}

@end