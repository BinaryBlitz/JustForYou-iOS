//
//  BBUniversalPresenter.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalPresenter.h"

#import "BBUniversalViewInput.h"
#import "BBUniversalInteractorInput.h"
#import "BBUniversalRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderModuleInput.h"

#import "BBMapAssembly.h"
#import "BBMapModuleInput.h"

@interface BBUniversalPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBNewOrderModuleInput> parentNewOrderModule;
@property (strong, nonatomic) id<BBMapModuleInput> mapModule;

@end

@implementation BBUniversalPresenter

#pragma mark - Методы BBUniversalModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule keyModule:(BBKeyModuleForUniversalModule)key {
    self.navigationModule = navigationModule;
    self.parentNewOrderModule = parentModule;
    [self _detectTitleForNavigationWithKey:key];
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)pushModuleWithNavigationModule:(id)navigationModule keyModule:(BBKeyModuleForUniversalModule)key {
    self.navigationModule = navigationModule;
    [self _detectTitleForNavigationWithKey:key];
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)_detectTitleForNavigationWithKey:(BBKeyModuleForUniversalModule)key {
    if (key == kNoneModule) {
        [self.view navigationTitle:kNameTitleNoneModule keyModule:key];
    } else if (key == kMyPayCardModule) {
        [self.view navigationTitle:kNameTitleMyPayCardModule keyModule:key];
    } else if (key == kMyProgramModule) {
        [self.view navigationTitle:kNameTitleMyProgramModule keyModule:key];
    } else if (key == kMyAddressModule) {
        [self.view navigationTitle:kNameTitleAddressModule keyModule:key];
    } else if (key == kMyHystoryPaymentModule) {
        [self.view navigationTitle:kNameTitleHystoryPaymentsModule keyModule:key];
    } else if (key == kSharesModule) {
        [self.view navigationTitle:kNameTitleSharesModule keyModule:key];
    } else if (key == kReplacementModule) {
        [self.view navigationTitle:kNameTitleReplacementModule keyModule:key];
    } else if (key == kAboutModule) {
        [self.view navigationTitle:kNameTitleAboutModule keyModule:key];
    } else {
        [self.view navigationTitle:kNameTitleNoneModule keyModule:key];
    }
}

#pragma mark - Методы BBUniversalViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)cellDidSelectWithAdress:(NSString *)adress {
    [self.parentNewOrderModule popAdressModuleWithAdress:adress];
}

- (void)viewWillAppear {
    [self.view settingView];
}

- (void)addBarButtonDidTap {
    [self.mapModule pushModuleWithNavigationModule:self.navigationModule];
}


#pragma mark - Методы BBUniversalInteractorOutput


#pragma mark - Lazy Load

- (id<BBMapModuleInput>)mapModule {
    if (!_mapModule) {
        _mapModule = [BBMapAssembly  createModule];
    }
    return _mapModule;
}

@end