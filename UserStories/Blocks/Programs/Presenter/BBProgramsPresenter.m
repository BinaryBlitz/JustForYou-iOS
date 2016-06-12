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

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBCardProgramAssembly.h"
#import "BBCardProgramModuleInput.h"

@interface BBProgramsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBCardProgramModuleInput> cardProgramModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> basketNavigationModule;

@property (nonatomic) NSInteger parentId;
@property (nonatomic) BOOL clearData;

@end

@implementation BBProgramsPresenter

#pragma mark - Методы BBProgramsModuleInput

- (void)configureModule {
    self.clearData = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentId:(NSInteger)parentId {
    self.navigModule = navigationModule;
    self.parentId = parentId;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}


#pragma mark - Методы BBProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    NSArray *res = [self.interactor checkProgramsInDataBaseWith:self.parentId];
    if (res && [res count] > 0) {
        self.clearData = NO;
        [self.view programsForTableView:res];
        [self.interactor listProgramsWithParentId:self.parentId];
    } else {
        [self.view showBackgroundLoaderView];
        [self.interactor listProgramsWithParentId:self.parentId];
    }
}

- (void)viewWillAppear {
    [self.interactor programsInDataBaseWithParentId:self.parentId];
}

- (void)programDidTapWithProgram:(BBProgram *)program {
    [self.cardProgramModule pushModuleWithNavigationModule:self.navigModule prog:program];
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBProgramsInteractorOutput

- (void)currentProgramsInDataBase:(NSArray *)programs {
    if ([programs count] > 0) {
        [self.view hideBackgroundLoaderView];
        [self.view programsForTableView:programs];
    } else {
        [self.view showBackgroundLoaderView];
        [self.interactor listProgramsWithParentId:self.parentId];
    }
}

- (void)programsSaveInDataBase {
    [self.view hideBackgroundLoaderView];
    [self.interactor programsInDataBaseWithParentId:self.parentId];
}

- (void)errorClient {
    if (self.clearData) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
    }
}

- (void)errorServer {
    if (self.clearData) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
    }
}

#pragma mark - Lazy Load

- (id<BBCardProgramModuleInput>) cardProgramModule {
    if (!_cardProgramModule) {
        _cardProgramModule = [BBCardProgramAssembly createModule];
    }
    return _cardProgramModule;
}

- (id<BBNavigationModuleInput>)basketNavigationModule {
    if (!_basketNavigationModule) {
        _basketNavigationModule = [BBNavigationAssembly createModule];
    }
    return _basketNavigationModule;
}

@end