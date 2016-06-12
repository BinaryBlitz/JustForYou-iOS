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

@property (strong, nonatomic) BBProgram *program;

@end

@implementation BBCardProgramPresenter

#pragma mark - Методы BBCardProgramModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule program:(BBProgram *)program {
    self.navigModule = navigationModule;
    self.program = program;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBCardProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    [self.view updateViewWithProgram:self.program];
}

- (void)viewWillAppear {
    
}

- (void)basketButtonDidTap {
    [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                  withNavigationController:[self.navigModule currentView]];
}

- (void)addInBasketButtonDidTap {
    [self.view showAddInBasketPopover];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
    [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину"];
}

#pragma mark - Методы BBCardProgramInteractorOutput

- (void)currentDaysInDataBase:(NSArray *)days {
    
}

- (void)daysSaveInDataBase {
    
}

- (void)errorServer {
    
}

- (void)errorClient {
    
}

#pragma makr - Lazy Load 

- (id<BBNavigationModuleInput>)basketNavigationModule {
    if (!_basketNavigationModule) {
        _basketNavigationModule = [BBNavigationAssembly createModule];
    }
    return _basketNavigationModule;
}

@end