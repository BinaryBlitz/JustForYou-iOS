//
//  BBDeliveryPresenter.m
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryPresenter.h"

#import "BBDeliveryViewInput.h"
#import "BBDeliveryInteractorInput.h"
#import "BBDeliveryRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderModuleInput.h"

#import "BBPurchases.h"

@interface BBDeliveryPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBNewOrderModuleInput> parentModule;

@property (assign, nonatomic) BBPurchases *purchase;

@end

@implementation BBDeliveryPresenter

#pragma mark - Методы BBDeliveryModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase {
    self.navigationModule = navigationModule;
    self.parentModule = parent;
    self.purchase = purchase;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBDeliveryViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view purchaseForCalendar:self.purchase];
}

- (void)viewWillDisappear {
    NSArray *dates = [self.view currentSelectionDates];
    [self.parentModule selectionDates:dates];
}

#pragma mark - Методы BBDeliveryInteractorOutput

@end