//
//  BBUniversalAssembly.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalAssembly.h"

#import "BBUniversalViewController.h"
#import "BBUniversalInteractor.h"
#import "BBUniversalPresenter.h"
#import "BBUniversalRouter.h"

@implementation BBUniversalAssembly


+ (id <BBUniversalModuleInput>)createModule {

    BBUniversalViewController *view = [self viewController];

    BBUniversalInteractor *interactor = [BBUniversalInteractor new];
    BBUniversalPresenter *presenter = [BBUniversalPresenter new];
    BBUniversalRouter *router = [BBUniversalRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBUniversalViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBUniversalViewController * vc = (BBUniversalViewController *)[sb instantiateViewControllerWithIdentifier:@"BBUniversalViewController"];
    return vc;
}

@end