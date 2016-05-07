//
//  BBBasketAssembly.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketAssembly.h"

#import "BBBasketViewController.h"
#import "BBBasketInteractor.h"
#import "BBBasketPresenter.h"
#import "BBBasketRouter.h"

@implementation BBBasketAssembly


+ (id <BBBasketModuleInput>)createModule {

    BBBasketViewController *view = [self viewController];

    BBBasketInteractor *interactor = [BBBasketInteractor new];
    BBBasketPresenter *presenter = [BBBasketPresenter new];
    BBBasketRouter *router = [BBBasketRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBBasketViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBBasketViewController * vc = (BBBasketViewController *)[sb instantiateViewControllerWithIdentifier:@"BBBasketViewController"];
    return vc;
}

@end