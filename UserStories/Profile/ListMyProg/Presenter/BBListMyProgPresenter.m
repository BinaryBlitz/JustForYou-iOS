//
//  BBListMyProgPresenter.m
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgPresenter.h"

#import "BBListMyProgViewInput.h"
#import "BBListMyProgInteractorInput.h"
#import "BBListMyProgRouterInput.h"

#import "BBNavigationModuleInput.h"
#import "BBProfileModuleInput.h"


@interface BBListMyProgPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBProfileModuleInput> parentModule;

@end

@implementation BBListMyProgPresenter

#pragma mark - Методы BBListMyProgModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule {
    self.navigationModule = navigationModule;
    self.parentModule = parentModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBListMyProgViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count programId:(NSInteger)programId {
//    [self.interactor addInOrdersUserOrderWithProgramId:programId countDay:count];
    [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину. Для продления пройдите в корзину для оплаты" cancelTitle:@"Продолжить"];
    
}

#pragma mark - Методы BBListMyProgInteractorOutput

@end