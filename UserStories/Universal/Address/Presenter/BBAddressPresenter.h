//
//  BBAddressPresenter.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressViewOutput.h"
#import "BBAddressInteractorOutput.h"
#import "BBAddressModuleInput.h"

@protocol BBAddressViewInput;
@protocol BBAddressInteractorInput;
@protocol BBAddressRouterInput;

@interface BBAddressPresenter : NSObject <BBAddressModuleInput, BBAddressViewOutput, BBAddressInteractorOutput>

@property (strong, nonatomic) id<BBAddressViewInput> view;
@property (strong, nonatomic) id<BBAddressInteractorInput> interactor;
@property (strong, nonatomic) id<BBAddressRouterInput> router;

@end
