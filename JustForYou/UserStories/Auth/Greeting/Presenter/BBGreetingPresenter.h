//
//  BBGreetingPresenter.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingViewOutput.h"
#import "BBGreetingInteractorOutput.h"
#import "BBGreetingModuleInput.h"

@protocol BBGreetingViewInput;
@protocol BBGreetingInteractorInput;
@protocol BBGreetingRouterInput;

@interface BBGreetingPresenter : NSObject <BBGreetingModuleInput, BBGreetingViewOutput, BBGreetingInteractorOutput>

@property (strong, nonatomic) id<BBGreetingViewInput> view;
@property (strong, nonatomic) id<BBGreetingInteractorInput> interactor;
@property (strong, nonatomic) id<BBGreetingRouterInput> router;

@end
