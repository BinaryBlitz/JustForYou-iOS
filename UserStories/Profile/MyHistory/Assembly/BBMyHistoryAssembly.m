//
//  BBMyHistoryAssembly.m
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryAssembly.h"

#import "BBMyHistoryViewController.h"
#import "BBMyHistoryInteractor.h"
#import "BBMyHistoryPresenter.h"
#import "BBMyHistoryRouter.h"

@implementation BBMyHistoryAssembly


+ (id <BBMyHistoryModuleInput>)createModule {

    BBMyHistoryViewController *view = [self viewController];

    BBMyHistoryInteractor *interactor = [BBMyHistoryInteractor new];
    BBMyHistoryPresenter *presenter = [BBMyHistoryPresenter new];
    BBMyHistoryRouter *router = [BBMyHistoryRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBMyHistoryViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    BBMyHistoryViewController * vc = (BBMyHistoryViewController *)[sb instantiateViewControllerWithIdentifier:@"BBMyHistoryViewController"];
    return vc;
}

@end