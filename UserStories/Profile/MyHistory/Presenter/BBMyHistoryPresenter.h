//
//  BBMyHistoryPresenter.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryViewOutput.h"
#import "BBMyHistoryInteractorOutput.h"
#import "BBMyHistoryModuleInput.h"

@protocol BBMyHistoryViewInput;
@protocol BBMyHistoryInteractorInput;
@protocol BBMyHistoryRouterInput;

@interface BBMyHistoryPresenter : NSObject <BBMyHistoryModuleInput, BBMyHistoryViewOutput, BBMyHistoryInteractorOutput>

@property (strong, nonatomic) id<BBMyHistoryViewInput> view;
@property (strong, nonatomic) id<BBMyHistoryInteractorInput> interactor;
@property (strong, nonatomic) id<BBMyHistoryRouterInput> router;

@end
