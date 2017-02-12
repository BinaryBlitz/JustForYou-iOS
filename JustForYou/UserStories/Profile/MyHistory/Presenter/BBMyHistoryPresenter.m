//
//  BBMyHistoryPresenter.m
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryPresenter.h"

#import "BBMyHistoryViewInput.h"
#import "BBMyHistoryInteractorInput.h"
#import "BBMyHistoryRouterInput.h"

#import "BBNavigationModuleInput.h"
#import "BBProfileModuleInput.h"


@interface BBMyHistoryPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBProfileModuleInput> parentModule;

@end

@implementation BBMyHistoryPresenter

#pragma mark - Методы BBMyHistoryModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule {
    self.navigationModule = navigationModule;
    self.parentModule = parentModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBMyHistoryViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor listMyHistoryOrder];
}

#pragma mark - Методы BBMyHistoryInteractorOutput

- (void)ordersWithArray:(NSArray *)orders {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view updateTableViewWithArrayObjects:orders];
}

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}


@end