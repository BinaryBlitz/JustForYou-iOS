//
//  BBProgramsRouter.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsRouterInput.h"

#import "BBProgramsPresenter.h"

@interface BBProgramsRouter : NSObject <BBProgramsRouterInput>

@property (weak, nonatomic) BBProgramsPresenter *presenter;

@end