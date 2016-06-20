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

@end

static NSString *kImageNameBasketFull = @"basketFull";
static NSString *kImageNameBasket = @"basket";

@implementation BBBlocksPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
//    [self _deleteBD];
    
    self.isEmptyRealm = [self.interactor checkObjectsInDataBase];
}

#warning delete after test

- (void)_deleteBD {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteAllObjects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

#pragma mark - Методы BBBlocksViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    if (self.isEmptyRealm) {
        [self.view showLoaderView];
        [self.interactor listBlocksWithKey:kStateCreateData];
    } else {
        [self.interactor blocksInDataBase];
        [self.interactor listBlocksWithKey:kStateUpdateData];
    }
}

- (void)viewWillAppear {
    [self.interactor checkBasket];
    [self.interactor blocksInDataBase];
}

- (void)didSelectRowWithBlockId:(NSInteger)blockId {
    [self.programsModule pushModuleWithNavigationModule:self.navigModule parentId:blockId];
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

- (void)errorClient {
    if (self.isEmptyRealm) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorClient];
    }
}

- (void)errorServer {
    if (self.isEmptyRealm) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
    }
}

- (void)currentProgramsInBasket:(NSArray *)programs {
    if ([programs count] > 0) {
        [self.view updateBasketButtonImageWithImageName:kImageNameBasketFull];
    } else {
        [self.view updateBasketButtonImageWithImageName:kImageNameBasket];
    }
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
