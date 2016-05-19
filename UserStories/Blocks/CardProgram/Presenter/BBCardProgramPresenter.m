//
//  BBCardProgramPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramPresenter.h"

#import "BBCardProgramViewInput.h"
#import "BBCardProgramInteractorInput.h"
#import "BBCardProgramRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBBasketAssembly.h"
#import "BBBasketModuleInput.h"

@interface BBCardProgramPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> basketNavigationModule;

@end

@implementation BBCardProgramPresenter

#pragma mark - Методы BBCardProgramModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBCardProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

- (void)addInBasketButtonDidTap {
    [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину"];
}

#pragma mark - Методы BBCardProgramInteractorOutput

#pragma makr - Lazy Load 

- (id<BBNavigationModuleInput>)basketNavigationModule {
    if (!_basketNavigationModule) {
        _basketNavigationModule = [BBNavigationAssembly createModule];
    }
    return _basketNavigationModule;
}

@end