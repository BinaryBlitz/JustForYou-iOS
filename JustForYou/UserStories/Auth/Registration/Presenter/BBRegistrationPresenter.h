//
//  BBRegistrationPresenter.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationViewOutput.h"
#import "BBRegistrationInteractorOutput.h"
#import "BBRegistrationModuleInput.h"

@protocol BBRegistrationViewInput;
@protocol BBRegistrationInteractorInput;
@protocol BBRegistrationRouterInput;

@interface BBRegistrationPresenter : NSObject <BBRegistrationModuleInput, BBRegistrationViewOutput, BBRegistrationInteractorOutput>

@property (strong, nonatomic) id<BBRegistrationViewInput> view;
@property (strong, nonatomic) id<BBRegistrationInteractorInput> interactor;
@property (strong, nonatomic) id<BBRegistrationRouterInput> router;

@end
