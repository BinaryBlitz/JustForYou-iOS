//
//  BBTabbarViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBTabbarViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)needInitialViewForContainer;

#pragma mark - TabBarItems

- (void)didPressItemPrograms;

- (void)didPressItemOrders;

- (void)didPressItemProfile;

- (void)didPressItemSupport;

@end