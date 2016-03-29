//
//  BBProfileAssembly.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileAssembly.h"

#import "BBProfileViewController.h"
#import "BBProfileInteractor.h"
#import "BBProfilePresenter.h"
#import "BBProfileRouter.h"

@implementation BBProfileAssembly


+ (id <BBProfileModuleInput>)createModule {

    BBProfileViewController *view = [self viewController];

    BBProfileInteractor *interactor = [BBProfileInteractor new];
    BBProfilePresenter *presenter = [BBProfilePresenter new];
    BBProfileRouter *router = [BBProfileRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBProfileViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBProfileViewController * vc = (BBProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"BBProfileViewController"];
    return vc;
}

@end