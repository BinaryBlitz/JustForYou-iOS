//
//  BBTabbarPresenter.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarViewOutput.h"
#import "BBTabbarInteractorOutput.h"
#import "BBTabbarModuleInput.h"

@protocol BBTabbarViewInput;
@protocol BBTabbarInteractorInput;
@protocol BBTabbarRouterInput;

@interface BBTabbarPresenter : NSObject <BBTabbarModuleInput, BBTabbarViewOutput, BBTabbarInteractorOutput>

@property (strong, nonatomic) id<BBTabbarViewInput> view;
@property (strong, nonatomic) id<BBTabbarInteractorInput> interactor;
@property (strong, nonatomic) id<BBTabbarRouterInput> router;

@end
