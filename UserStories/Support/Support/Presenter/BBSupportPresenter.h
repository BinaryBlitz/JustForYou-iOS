//
//  BBSupportPresenter.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportViewOutput.h"
#import "BBSupportInteractorOutput.h"
#import "BBSupportModuleInput.h"

@protocol BBSupportViewInput;
@protocol BBSupportInteractorInput;
@protocol BBSupportRouterInput;

@interface BBSupportPresenter : NSObject <BBSupportModuleInput, BBSupportViewOutput, BBSupportInteractorOutput>

@property (strong, nonatomic) id<BBSupportViewInput> view;
@property (strong, nonatomic) id<BBSupportInteractorInput> interactor;
@property (strong, nonatomic) id<BBSupportRouterInput> router;

@end
