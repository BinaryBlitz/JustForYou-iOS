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

@property (nonatomic, strong) id<BBTabbarViewInput> view;
@property (nonatomic, strong) id<BBTabbarInteractorInput> interactor;
@property (nonatomic, strong) id<BBTabbarRouterInput> router;

@end
