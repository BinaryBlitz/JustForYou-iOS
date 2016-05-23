//
//  BBNewOrderPresenter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderPresenter.h"

#import "BBNewOrderViewInput.h"
#import "BBNewOrderInteractorInput.h"
#import "BBNewOrderRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBDeliveryAssembly.h"
#import "BBDeliveryModuleInput.h"

#import "BBUniversalAssembly.h"
#import "BBUniversalModuleInput.h"

@interface BBNewOrderPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBDeliveryModuleInput> deliveryModule;
@property (strong, nonatomic) id<BBUniversalModuleInput> universalModule;

@end

@implementation BBNewOrderPresenter

#pragma mark - Методы BBNewOrderModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule withProgram:(NSInteger)program {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)popAdressModuleWithAdress:(NSString *)adress {
    [self.view adressForAdressTableViewCell:adress];
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBNewOrderViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)countDayCellDidTap {
    [self.deliveryModule pushModuleWithNavigationModule:self.navigationModule];
}

- (void)adresCellDidTap {
    [self.universalModule pushModuleWithNavigationModule:self.navigationModule parentModule:self keyModule:kMyAddressForOrderModule];
}

#pragma mark - Методы BBNewOrderInteractorOutput

#pragma mark - Lazy Load

-(id<BBDeliveryModuleInput>)deliveryModule {
    if (!_deliveryModule) {
        _deliveryModule = [BBDeliveryAssembly createModule];
    }
    return _deliveryModule;
}

- (id<BBUniversalModuleInput>)universalModule {
    if (!_universalModule) {
        _universalModule = [BBUniversalAssembly createModule];
    }
    return _universalModule;
}


@end