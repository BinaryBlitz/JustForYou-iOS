//
//  BBTabbarPresenter.m
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarPresenter.h"

#import "BBTabbarViewInput.h"
#import "BBTabbarInteractorInput.h"
#import "BBTabbarRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBBlocksAssembly.h"
#import "BBBlocksModuleInput.h"

@interface BBTabbarPresenter()

@property (nonatomic) id<BBNavigationModuleInput> navigationBlockModule;
@property (nonatomic) id<BBNavigationModuleInput> navigationOrderModule;
@property (nonatomic) id<BBNavigationModuleInput> navigationProfileModule;
@property (nonatomic) id<BBNavigationModuleInput> navigationSupportModule;


#warning delete
@property (nonatomic) id<BBBlocksModuleInput> blockModule;

@property (strong, nonatomic) NSMutableArray *arrayMainModules;


@end

@implementation BBTabbarPresenter

#pragma mark - Методы BBTabbarModuleInput

- (void)configureModule {
    self.arrayMainModules = [NSMutableArray array];
    [self.arrayMainModules addObject:[self.navigationBlockModule currentViewWithLoadModule:BBLoadBlockModule]];
    [self.arrayMainModules addObject:[self.navigationOrderModule currentViewWithLoadModule:BBLoadOrdersModule]];
    [self.arrayMainModules addObject:[self.navigationSupportModule currentViewWithLoadModule:BBLoadSupportModule]];
    [self.arrayMainModules addObject:[self.navigationProfileModule currentViewWithLoadModule:BBLoadProfileModule]];
    [self.view setItemsBar:self.arrayMainModules];
}

- (id)currentView {
    return self.view;
}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
}

#pragma mark - Методы BBTabbarViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
//    [self.arrayMainModules addObject:[self.navigationBlockModule currentViewWithLoadModule:BBLoadBlockModule]];
//    [self.arrayMainModules addObject:[self.navigationOrderModule currentViewWithLoadModule:BBLoadOrdersModule]];
//    [self.arrayMainModules addObject:[self.navigationProfileModule currentViewWithLoadModule:BBLoadProfileModule]];
//    [self.arrayMainModules addObject:[self.navigationSupportModule currentViewWithLoadModule:BBLoadSupportModule]];
//    [self.view setItemsBar:self.arrayMainModules];
}


- (void)didPressItemPrograms {
    
}

- (void)didPressItemOrders {
    
}

- (void)didPressItemProfile {
    
}

- (void)didPressItemSupport {
    
}


#pragma mark - Методы BBTabbarInteractorOutput


#pragma mark - Lazy Load

- (id<BBNavigationModuleInput>) navigationBlockModule {
    if (!_navigationBlockModule) {
        _navigationBlockModule = [BBNavigationAssembly createModule];
    }
    return _navigationBlockModule;
}

- (id<BBNavigationModuleInput>) navigationOrderModule {
    if (!_navigationOrderModule) {
        _navigationOrderModule = [BBNavigationAssembly createModule];
    }
    return _navigationOrderModule;
}

- (id<BBNavigationModuleInput>) navigationProfileModule {
    if (!_navigationProfileModule) {
        _navigationProfileModule = [BBNavigationAssembly createModule];
    }
    return _navigationProfileModule;
}

- (id<BBNavigationModuleInput>) navigationSupportModule {
    if (!_navigationSupportModule) {
        _navigationSupportModule = [BBNavigationAssembly createModule];
    }
    return _navigationSupportModule;
}




#warning DELETE

- (id<BBBlocksModuleInput>) blockModule {
    if (!_blockModule) {
        _blockModule = [BBBlocksAssembly createModule];
    }
    return _blockModule;
}


@end