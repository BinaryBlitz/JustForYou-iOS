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

@interface BBUniversalPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBUniversalPresenter

#pragma mark - Методы BBUniversalModuleInput

- (void)configureModule {
    
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

#pragma mark - Методы BBUniversalInteractorOutput

@end