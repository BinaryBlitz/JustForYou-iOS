//
//  BBMyProgramsPresenter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsPresenter.h"

#import "BBMyProgramsViewInput.h"
#import "BBMyProgramsInteractorInput.h"
#import "BBMyProgramsRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderAssembly.h"
#import "BBNewOrderModuleInput.h"

@interface BBMyProgramsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBNewOrderModuleInput> neworderModule;


@end

@implementation BBMyProgramsPresenter

#pragma mark - Методы BBMyProgramsModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBMyProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)didSelectRowWithProgram:(NSInteger)program {
    [self.neworderModule pushModuleWithNavigationModule:self.navigationModule withProgram:program];
}

#pragma mark - Методы BBMyProgramsInteractorOutput

#pragma  mark - Lazy Load

- (id<BBNewOrderModuleInput>)neworderModule {
    if (!_neworderModule) {
        _neworderModule = [BBNewOrderAssembly createModule];
    }
    return _neworderModule;
}

@end