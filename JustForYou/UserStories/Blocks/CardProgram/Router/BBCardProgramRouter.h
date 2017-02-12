//
//  BBCardProgramRouter.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramRouterInput.h"

#import "BBCardProgramPresenter.h"

@interface BBCardProgramRouter : NSObject <BBCardProgramRouterInput>

@property (weak, nonatomic) BBCardProgramPresenter *presenter;

@end