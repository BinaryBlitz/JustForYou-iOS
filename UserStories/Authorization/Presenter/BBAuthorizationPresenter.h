//
//  BBAuthorizationPresenter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationViewOutput.h"
#import "BBAuthorizationInteractorOutput.h"
#import "BBAuthorizationModuleInput.h"

@protocol BBAuthorizationViewInput;
@protocol BBAuthorizationInteractorInput;
@protocol BBAuthorizationRouterInput;

@interface BBAuthorizationPresenter : NSObject <BBAuthorizationModuleInput, BBAuthorizationViewOutput, BBAuthorizationInteractorOutput>

@property (nonatomic, strong) id<BBAuthorizationViewInput> view;
@property (nonatomic, strong) id<BBAuthorizationInteractorInput> interactor;
@property (nonatomic, strong) id<BBAuthorizationRouterInput> router;

@end
