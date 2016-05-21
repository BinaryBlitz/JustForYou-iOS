//
//  BBUniversalPresenter.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalViewOutput.h"
#import "BBUniversalInteractorOutput.h"
#import "BBUniversalModuleInput.h"

@protocol BBUniversalViewInput;
@protocol BBUniversalInteractorInput;
@protocol BBUniversalRouterInput;

@interface BBUniversalPresenter : NSObject <BBUniversalModuleInput, BBUniversalViewOutput, BBUniversalInteractorOutput>

@property (strong, nonatomic) id<BBUniversalViewInput> view;
@property (strong, nonatomic) id<BBUniversalInteractorInput> interactor;
@property (strong, nonatomic) id<BBUniversalRouterInput> router;

@end
