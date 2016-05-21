//
//  BBNewOrderAssembly.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderAssembly.h"

#import "BBNewOrderViewController.h"
#import "BBNewOrderInteractor.h"
#import "BBNewOrderPresenter.h"
#import "BBNewOrderRouter.h"

@implementation BBNewOrderAssembly


+ (id <BBNewOrderModuleInput>)createModule {

    BBNewOrderViewController *view = [self viewController];

    BBNewOrderInteractor *interactor = [BBNewOrderInteractor new];
    BBNewOrderPresenter *presenter = [BBNewOrderPresenter new];
    BBNewOrderRouter *router = [BBNewOrderRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBNewOrderViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBNewOrderViewController * vc = (BBNewOrderViewController *)[sb instantiateViewControllerWithIdentifier:@"BBNewOrderViewController"];
    return vc;
}

@end