//
//  BBCardProgramAssembly.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramAssembly.h"

#import "BBCardProgramViewController.h"
#import "BBCardProgramInteractor.h"
#import "BBCardProgramPresenter.h"
#import "BBCardProgramRouter.h"

@implementation BBCardProgramAssembly


+ (id <BBCardProgramModuleInput>)createModule {

    BBCardProgramViewController *view = [self viewController];

    BBCardProgramInteractor *interactor = [BBCardProgramInteractor new];
    BBCardProgramPresenter *presenter = [BBCardProgramPresenter new];
    BBCardProgramRouter *router = [BBCardProgramRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBCardProgramViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBCardProgramViewController * vc = (BBCardProgramViewController *)[sb instantiateViewControllerWithIdentifier:@"BBCardProgramViewController"];
    return vc;
}

@end