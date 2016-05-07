//
//  BBBlocksPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksPresenter.h"

#import "BBBlocksViewInput.h"
#import "BBBlocksInteractorInput.h"
#import "BBBlocksRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBProgramsAssembly.h"
#import "BBProgramsModuleInput.h"

#import "BBBasketAssembly.h"
#import "BBBasketModuleInput.h"

@interface BBBlocksPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBProgramsModuleInput> programsModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> basketNavigationModule;

@end

@implementation BBBlocksPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

#pragma mark - Методы BBBlocksViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)didSelectRow {
    [self.programsModule pushModuleWithNavigationModule:self.navigModule];
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBBlocksInteractorOutput

#pragma mark - Lazy Load

- (id<BBProgramsModuleInput>) programsModule {
    if (!_programsModule) {
        _programsModule = [BBProgramsAssembly createModule];
    }
    return _programsModule;
}

- (id<BBNavigationModuleInput>)basketNavigationModule {
    if (!_basketNavigationModule) {
        _basketNavigationModule = [BBNavigationAssembly createModule];
    }
    return _basketNavigationModule;
}

@end