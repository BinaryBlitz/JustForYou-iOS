//
//  BBPaymentPresenter.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentViewOutput.h"
#import "BBPaymentInteractorOutput.h"
#import "BBPaymentModuleInput.h"

@protocol BBPaymentViewInput;
@protocol BBPaymentInteractorInput;
@protocol BBPaymentRouterInput;

@interface BBPaymentPresenter : NSObject <BBPaymentModuleInput, BBPaymentViewOutput, BBPaymentInteractorOutput>

@property (strong, nonatomic) id<BBPaymentViewInput> view;
@property (strong, nonatomic) id<BBPaymentInteractorInput> interactor;
@property (strong, nonatomic) id<BBPaymentRouterInput> router;

@end
