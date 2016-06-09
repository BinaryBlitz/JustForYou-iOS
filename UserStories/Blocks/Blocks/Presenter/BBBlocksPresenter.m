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

@property (nonatomic) BOOL isEmptyRealm;
@property (strong, nonatomic) RLMNotificationToken *notificationToken;

@end

@implementation BBBlocksPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    self.isEmptyRealm = [self.interactor checkObjectsInDataBase];
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (void)_updateBlocksOnBackground {
    [self.interactor listBlocksWithKey:kStateUpdateData];
}

#pragma mark - Методы BBBlocksViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    if (self.isEmptyRealm) {
        [self.view showLoaderView];
        [self.interactor listBlocksWithKey:kStateCreateData];
    } else {
        [self.interactor blocksInDataBase];
        [self _updateBlocksOnBackground];
    }
}

- (void)viewWillAppear {
    [self.interactor blocksInDataBase];
}

- (void)didSelectRow {
    [self.programsModule pushModuleWithNavigationModule:self.navigModule];
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBBlocksInteractorOutput

- (void)blocksSaveInDataBase {
    [self.view hideLoaderView];
    [self.interactor blocksInDataBase];
}

- (void)currentBlocksInDataBase:(NSArray *)blocks {
    [self.view blocksForTableView:blocks];
}

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