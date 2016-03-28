//
//  BBNavigationPresenter.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationViewOutput.h"
#import "BBNavigationInteractorOutput.h"
#import "BBNavigationModuleInput.h"

@protocol BBNavigationViewInput;
@protocol BBNavigationInteractorInput;
@protocol BBNavigationRouterInput;

@interface BBNavigationPresenter : NSObject <BBNavigationModuleInput, BBNavigationViewOutput, BBNavigationInteractorOutput>

@property (nonatomic, strong) id<BBNavigationViewInput> view;
@property (nonatomic, strong) id<BBNavigationInteractorInput> interactor;
@property (nonatomic, strong) id<BBNavigationRouterInput> router;

@end
