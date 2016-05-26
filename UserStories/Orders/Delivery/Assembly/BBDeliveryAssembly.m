//
//  BBDeliveryAssembly.m
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryAssembly.h"

#import "BBDeliveryViewController.h"
#import "BBDeliveryInteractor.h"
#import "BBDeliveryPresenter.h"
#import "BBDeliveryRouter.h"

@implementation BBDeliveryAssembly


+ (id <BBDeliveryModuleInput>)createModule {

    BBDeliveryViewController *view = [self viewController];

    BBDeliveryInteractor *interactor = [BBDeliveryInteractor new];
    BBDeliveryPresenter *presenter = [BBDeliveryPresenter new];
    BBDeliveryRouter *router = [BBDeliveryRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBDeliveryViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Orders" bundle:nil];
    BBDeliveryViewController * vc = (BBDeliveryViewController *)[sb instantiateViewControllerWithIdentifier:@"BBDeliveryViewController"];
    return vc;
}

@end