//
//  BBSupportAssembly.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportAssembly.h"

#import "BBSupportViewController.h"
#import "BBSupportInteractor.h"
#import "BBSupportPresenter.h"
#import "BBSupportRouter.h"

@implementation BBSupportAssembly


+ (id <BBSupportModuleInput>)createModule {

    BBSupportViewController *view = [self viewController];

    BBSupportInteractor *interactor = [BBSupportInteractor new];
    BBSupportPresenter *presenter = [BBSupportPresenter new];
    BBSupportRouter *router = [BBSupportRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBSupportViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBSupportViewController * vc = (BBSupportViewController *)[sb instantiateViewControllerWithIdentifier:@"BBSupportViewController"];
    return vc;
}

@end