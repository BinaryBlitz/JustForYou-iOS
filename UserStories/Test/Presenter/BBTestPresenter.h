//
//  BBTestPresenter.h
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestViewOutput.h"
#import "BBTestInteractorOutput.h"
#import "BBTestModuleInput.h"

@protocol BBTestViewInput;
@protocol BBTestInteractorInput;
@protocol BBTestRouterInput;

@interface BBTestPresenter : NSObject <BBTestModuleInput, BBTestViewOutput, BBTestInteractorOutput>

@property (nonatomic, strong) id<BBTestViewInput> view;
@property (nonatomic, strong) id<BBTestInteractorInput> interactor;
@property (nonatomic, strong) id<BBTestRouterInput> router;

@end
