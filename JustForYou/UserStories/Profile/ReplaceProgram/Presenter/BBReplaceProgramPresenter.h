//
//  BBReplaceProgramPresenter.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramViewOutput.h"
#import "BBReplaceProgramInteractorOutput.h"
#import "BBReplaceProgramModuleInput.h"

@protocol BBReplaceProgramViewInput;
@protocol BBReplaceProgramInteractorInput;
@protocol BBReplaceProgramRouterInput;

@interface BBReplaceProgramPresenter : NSObject <BBReplaceProgramModuleInput, BBReplaceProgramViewOutput, BBReplaceProgramInteractorOutput>

@property (strong, nonatomic) id<BBReplaceProgramViewInput> view;
@property (strong, nonatomic) id<BBReplaceProgramInteractorInput> interactor;
@property (strong, nonatomic) id<BBReplaceProgramRouterInput> router;

@end
