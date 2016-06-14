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

@property (nonatomic) NSInteger parentId;
@property (nonatomic) BOOL clearData;

@end

@implementation BBCardProgramPresenter

#pragma mark - Методы BBCardProgramModuleInput

- (void)configureModule {
    self.clearData = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule prog:(NSInteger)prog {
    self.navigModule = navigationModule;
    self.parentId = prog;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBCardProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
   }

- (void)viewWillAppear {
    NSArray *res = [self.interactor checkDaysInDataBaseWith:self.parentId];
    if (res && [res count] > 0) {
        self.clearData = NO;
        [self.interactor programInDataBaseWithParentId:self.parentId];
        [self.interactor listDaysWithParentId:self.parentId];
    } else {
        [self.view showLoaderView];
        [self.interactor listDaysWithParentId:self.parentId];
    }
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

- (void)addInBasketButtonDidTap {
    [self.view showAddInBasketPopover];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
    [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину" cancelTitle:@"Продолжить"];
}

#pragma mark - Методы BBCardProgramInteractorOutput

- (void)currentProgramInDataBase:(BBProgram *)program {
    if (program.programId) {
        [self.view hideLoaderView];
        [self.view updateViewWithProgram:program.programId];
    } else {
        [self.view showLoaderView];
        [self.interactor listDaysWithParentId:self.parentId];
    }
}

- (void)daysSaveInDataBase {
    [self.view hideLoaderView];
    [self.interactor programInDataBaseWithParentId:self.parentId];
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


#pragma makr - Lazy Load 

- (id<BBNavigationModuleInput>)basketNavigationModule {
    if (!_basketNavigationModule) {
        _basketNavigationModule = [BBNavigationAssembly createModule];
    }
    return _basketNavigationModule;
}

@end