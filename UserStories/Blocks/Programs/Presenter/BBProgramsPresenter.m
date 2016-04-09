//
//  BBProgramsPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsPresenter.h"

#import "BBProgramsViewInput.h"
#import "BBProgramsInteractorInput.h"
#import "BBProgramsRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBCardProgramAssembly.h"
#import "BBCardProgramModuleInput.h"

@interface BBProgramsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBCardProgramModuleInput> cardProgramModule;

@end

@implementation BBProgramsPresenter

#pragma mark - Методы BBProgramsModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)programDidTap {
    [self.cardProgramModule pushModuleWithNavigationModule:self.navigModule];
}

#pragma mark - Методы BBProgramsInteractorOutput

#pragma mark - Lazy Load

- (id<BBCardProgramModuleInput>) cardProgramModule {
    if (!_cardProgramModule) {
        _cardProgramModule = [BBCardProgramAssembly createModule];
    }
    return _cardProgramModule;
}


@end