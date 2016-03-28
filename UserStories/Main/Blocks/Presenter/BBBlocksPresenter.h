//
//  BBBlocksPresenter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksViewOutput.h"
#import "BBBlocksInteractorOutput.h"
#import "BBBlocksModuleInput.h"

@protocol BBBlocksViewInput;
@protocol BBBlocksInteractorInput;
@protocol BBBlocksRouterInput;

@interface BBBlocksPresenter : NSObject <BBBlocksModuleInput, BBBlocksViewOutput, BBBlocksInteractorOutput>

@property (strong, nonatomic) id<BBBlocksViewInput> view;
@property (strong, nonatomic) id<BBBlocksInteractorInput> interactor;
@property (strong, nonatomic) id<BBBlocksRouterInput> router;

@end
