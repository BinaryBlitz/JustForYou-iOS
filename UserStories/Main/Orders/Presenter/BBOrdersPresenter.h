//
//  BBOrdersPresenter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersViewOutput.h"
#import "BBOrdersInteractorOutput.h"
#import "BBOrdersModuleInput.h"

@protocol BBOrdersViewInput;
@protocol BBOrdersInteractorInput;
@protocol BBOrdersRouterInput;

@interface BBOrdersPresenter : NSObject <BBOrdersModuleInput, BBOrdersViewOutput, BBOrdersInteractorOutput>

@property (strong, nonatomic) id<BBOrdersViewInput> view;
@property (strong, nonatomic) id<BBOrdersInteractorInput> interactor;
@property (strong, nonatomic) id<BBOrdersRouterInput> router;

@end
