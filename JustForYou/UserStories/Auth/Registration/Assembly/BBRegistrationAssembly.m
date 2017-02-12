//
//  BBRegistrationAssembly.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationAssembly.h"

#import "BBRegistrationViewController.h"
#import "BBRegistrationInteractor.h"
#import "BBRegistrationPresenter.h"
#import "BBRegistrationRouter.h"

@implementation BBRegistrationAssembly


+ (id <BBRegistrationModuleInput>)createModule {

    BBRegistrationViewController *view = [self viewController];

    BBRegistrationInteractor *interactor = [BBRegistrationInteractor new];
    BBRegistrationPresenter *presenter = [BBRegistrationPresenter new];
    BBRegistrationRouter *router = [BBRegistrationRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBRegistrationViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Authorizate" bundle:nil];
    BBRegistrationViewController * vc = (BBRegistrationViewController *)[sb instantiateViewControllerWithIdentifier:@"BBRegistrationViewController"];
    return vc;
}

@end