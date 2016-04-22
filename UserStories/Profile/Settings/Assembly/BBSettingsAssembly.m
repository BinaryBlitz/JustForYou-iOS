//
//  BBSettingsAssembly.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsAssembly.h"

#import "BBSettingsViewController.h"
#import "BBSettingsInteractor.h"
#import "BBSettingsPresenter.h"
#import "BBSettingsRouter.h"

@implementation BBSettingsAssembly


+ (id <BBSettingsModuleInput>)createModule {

    BBSettingsViewController *view = [self viewController];

    BBSettingsInteractor *interactor = [BBSettingsInteractor new];
    BBSettingsPresenter *presenter = [BBSettingsPresenter new];
    BBSettingsRouter *router = [BBSettingsRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBSettingsViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBSettingsViewController * vc = (BBSettingsViewController *)[sb instantiateViewControllerWithIdentifier:@"BBSettingsViewController"];
    return vc;
}

@end