//
//  BBReplacementPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementPresenter.h"

#import "BBReplacementViewInput.h"
#import "BBReplacementInteractorInput.h"
#import "BBReplacementRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBReplacementAssembly.h"

@interface BBReplacementPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBReplacementModuleInput> replacementModule;

@property (assign, nonatomic) BBTypeReplacementController keyType;

@end

@implementation BBReplacementPresenter

#pragma mark - Методы BBReplacementModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule withType:(BBTypeReplacementController)type {
    self.navigationModule = navigationModule;
    self.keyType = type;
    [self.view typeForController:type];
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)_currentReplacementUser {
    [self.interactor currentReplacementUser];
}

#pragma mark - Методы BBReplacementViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    if (self.keyType == kViewReplacementType) {
        [self _currentReplacementUser];
    }
}

- (void)addBarButtonDidTap {
    if ([self.view countReplacementInTableView] < 3) {
        [self.replacementModule pushModuleWithNavigationModule:self.navigationModule withType:kAddReplacementType];
    } else {
        [self.view presentAlertControllerWithMessage:@"Вы не можете добавить еще одну замену. Пожалуйста, удалите одну или несколько замен"];
    }
}

- (void)cellDidSelectWithText:(NSString *)text {
    [self.interactor addInCurrentArrayReplacementNewElement:text];
}

- (void)deleteElementWithText:(NSString *)text {
    [self.interactor deleteElementInArrayWithElement:text];
}

#pragma mark - Методы BBReplacementInteractorOutput

- (void)currentReplacementInData:(NSArray *)replacement {
    [self.view currentReplacementArray:replacement];
}

- (void)currentReplacementUpdate {
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)elemetnDidDeleteWithNewArray:(NSArray *)array {
    [self.view endUpdateTableViewWithNewReplacement:array];
}

#pragma mark - Lazy Load

- (id<BBReplacementModuleInput>) replacementModule {
    if (!_replacementModule) {
        _replacementModule = [BBReplacementAssembly createModule];
    }
    return _replacementModule;
}

@end