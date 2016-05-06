//
//  BBNewOrderPresenter.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderViewOutput.h"
#import "BBNewOrderInteractorOutput.h"
#import "BBNewOrderModuleInput.h"

@protocol BBNewOrderViewInput;
@protocol BBNewOrderInteractorInput;
@protocol BBNewOrderRouterInput;

@interface BBNewOrderPresenter : NSObject <BBNewOrderModuleInput, BBNewOrderViewOutput, BBNewOrderInteractorOutput>

@property (strong, nonatomic) id<BBNewOrderViewInput> view;
@property (strong, nonatomic) id<BBNewOrderInteractorInput> interactor;
@property (strong, nonatomic) id<BBNewOrderRouterInput> router;

@end
