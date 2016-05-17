//
//  BBGreetingAssembly.m
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingAssembly.h"

#import "BBGreetingViewController.h"
#import "BBGreetingInteractor.h"
#import "BBGreetingPresenter.h"
#import "BBGreetingRouter.h"

@implementation BBGreetingAssembly


+ (id <BBGreetingModuleInput>)createModule {

    BBGreetingViewController *view = [self viewController];

    BBGreetingInteractor *interactor = [BBGreetingInteractor new];
    BBGreetingPresenter *presenter = [BBGreetingPresenter new];
    BBGreetingRouter *router = [BBGreetingRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBGreetingViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Authorizate" bundle:nil];
    BBGreetingViewController * vc = (BBGreetingViewController *)[sb instantiateViewControllerWithIdentifier:@"BBGreetingViewController"];
    return vc;
}

@end