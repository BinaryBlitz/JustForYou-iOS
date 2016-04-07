//
//  BBBlocksAssembly.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksAssembly.h"

#import "BBBlocksViewController.h"
#import "BBBlocksInteractor.h"
#import "BBBlocksPresenter.h"
#import "BBBlocksRouter.h"

@implementation BBBlocksAssembly


+ (id <BBBlocksModuleInput>)createModule {

    BBBlocksViewController *view = [self viewController];

    BBBlocksInteractor *interactor = [BBBlocksInteractor new];
    BBBlocksPresenter *presenter = [BBBlocksPresenter new];
    BBBlocksRouter *router = [BBBlocksRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBBlocksViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBBlocksViewController * vc = (BBBlocksViewController *)[sb instantiateViewControllerWithIdentifier:@"BBBlocksViewController"];
    return vc;
}

@end