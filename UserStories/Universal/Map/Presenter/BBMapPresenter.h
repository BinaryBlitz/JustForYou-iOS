//
//  BBMapPresenter.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapViewOutput.h"
#import "BBMapInteractorOutput.h"
#import "BBMapModuleInput.h"

@protocol BBMapViewInput;
@protocol BBMapInteractorInput;
@protocol BBMapRouterInput;

@interface BBMapPresenter : NSObject <BBMapModuleInput, BBMapViewOutput, BBMapInteractorOutput>

@property (strong, nonatomic) id<BBMapViewInput> view;
@property (strong, nonatomic) id<BBMapInteractorInput> interactor;
@property (strong, nonatomic) id<BBMapRouterInput> router;

@end
