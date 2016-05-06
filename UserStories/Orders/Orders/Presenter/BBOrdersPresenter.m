//
//  BBOrdersPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersPresenter.h"

#import "BBOrdersViewInput.h"
#import "BBOrdersInteractorInput.h"
#import "BBOrdersRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBMyProgramsAssembly.h"
#import "BBMyProgramsModuleInput.h"

@interface BBOrdersPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBMyProgramsModuleInput> myProgramModule;

@end

@implementation BBOrdersPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}
#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)addNewOrderButtonDidTap {
    [self.myProgramModule pushModuleWithNavigationModule:self.navigModule];
}

#pragma mark - Методы BBOrdersInteractorOutput

- (id<BBMyProgramsModuleInput>)myProgramModule {
    if (!_myProgramModule) {
        _myProgramModule = [BBMyProgramsAssembly createModule];
    }
    return _myProgramModule;
}

@end