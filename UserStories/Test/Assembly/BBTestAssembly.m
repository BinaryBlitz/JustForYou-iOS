//
//  BBTestAssembly.m
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestAssembly.h"

#import "BBTestViewController.h"
#import "BBTestInteractor.h"
#import "BBTestPresenter.h"
#import "BBTestRouter.h"

@implementation BBTestAssembly


+ (id <BBTestModuleInput>)createModule {
    BBTestViewController *view = [self viewController];

    BBTestInteractor *interactor = [BBTestInteractor new];
    BBTestPresenter *presenter = [BBTestPresenter new];
    BBTestRouter *router = [BBTestRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBTestViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBTestViewController * vc = (BBTestViewController *)[sb instantiateViewControllerWithIdentifier:@"BBTestViewController"];
    return vc;
}

@end