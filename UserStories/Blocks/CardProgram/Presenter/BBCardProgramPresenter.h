//
//  BBCardProgramPresenter.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramViewOutput.h"
#import "BBCardProgramInteractorOutput.h"
#import "BBCardProgramModuleInput.h"

@protocol BBCardProgramViewInput;
@protocol BBCardProgramInteractorInput;
@protocol BBCardProgramRouterInput;

@interface BBCardProgramPresenter : NSObject <BBCardProgramModuleInput, BBCardProgramViewOutput, BBCardProgramInteractorOutput>

@property (strong, nonatomic) id<BBCardProgramViewInput> view;
@property (strong, nonatomic) id<BBCardProgramInteractorInput> interactor;
@property (strong, nonatomic) id<BBCardProgramRouterInput> router;

@end
