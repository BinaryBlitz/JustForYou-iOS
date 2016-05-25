//
//  BBMapAssembly.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapAssembly.h"

#import "BBMapViewController.h"
#import "BBMapInteractor.h"
#import "BBMapPresenter.h"
#import "BBMapRouter.h"

@implementation BBMapAssembly


+ (id <BBMapModuleInput>)createModule {

    BBMapViewController *view = [self viewController];

    BBMapInteractor *interactor = [BBMapInteractor new];
    BBMapPresenter *presenter = [BBMapPresenter new];
    BBMapRouter *router = [BBMapRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBMapViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBMapViewController * vc = (BBMapViewController *)[sb instantiateViewControllerWithIdentifier:@"BBMapViewController"];
    return vc;
}

@end