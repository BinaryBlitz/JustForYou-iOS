//
//  BBMapViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMaps;

@protocol BBMapViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)myLocationButtonDidTap;

- (void)addButtonDidTap;

- (void)textFieldDidBeginEditing;

- (void)mapViewIdleAtCameraPosition:(GMSCameraPosition *)position;

- (void)updateSearchResultsWithText:(NSString *)searchText;

@end
