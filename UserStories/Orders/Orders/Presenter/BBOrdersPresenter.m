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

static NSString *kPurchasesEmpty = @"Вы не можете создать новый заказ так как у вас нет купленных программ";

@implementation BBOrdersPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status {
    [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    
}

- (void)addNewOrderButtonDidTap {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor listPurchasesUser];
}

#pragma mark - Методы BBOrdersInteractorOutput

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

- (void)currentPurchasesUserWithArray:(NSArray *)array {
    [self.view hideBackgroundLoaderViewWithAlpha];
    if ([array count] > 0) {
        [self.myProgramModule pushModuleWithNavigationModule:self.navigModule parent:self purchasesArray:array];
    } else {
        [self.view presentAlertWithTitle:nil message:kPurchasesEmpty];
    }
}

#pragma  mark - Lazy Load

- (id<BBMyProgramsModuleInput>)myProgramModule {
    if (!_myProgramModule) {
        _myProgramModule = [BBMyProgramsAssembly createModule];
    }
    return _myProgramModule;
}

@end