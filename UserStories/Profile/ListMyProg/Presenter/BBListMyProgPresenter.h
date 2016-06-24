//
//  BBListMyProgPresenter.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgViewOutput.h"
#import "BBListMyProgInteractorOutput.h"
#import "BBListMyProgModuleInput.h"

@protocol BBListMyProgViewInput;
@protocol BBListMyProgInteractorInput;
@protocol BBListMyProgRouterInput;

@interface BBListMyProgPresenter : NSObject <BBListMyProgModuleInput, BBListMyProgViewOutput, BBListMyProgInteractorOutput>

@property (strong, nonatomic) id<BBListMyProgViewInput> view;
@property (strong, nonatomic) id<BBListMyProgInteractorInput> interactor;
@property (strong, nonatomic) id<BBListMyProgRouterInput> router;

@end
