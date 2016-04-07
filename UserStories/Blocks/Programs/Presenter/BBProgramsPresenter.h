//
//  BBProgramsPresenter.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsViewOutput.h"
#import "BBProgramsInteractorOutput.h"
#import "BBProgramsModuleInput.h"

@protocol BBProgramsViewInput;
@protocol BBProgramsInteractorInput;
@protocol BBProgramsRouterInput;

@interface BBProgramsPresenter : NSObject <BBProgramsModuleInput, BBProgramsViewOutput, BBProgramsInteractorOutput>

@property (strong, nonatomic) id<BBProgramsViewInput> view;
@property (strong, nonatomic) id<BBProgramsInteractorInput> interactor;
@property (strong, nonatomic) id<BBProgramsRouterInput> router;

@end
