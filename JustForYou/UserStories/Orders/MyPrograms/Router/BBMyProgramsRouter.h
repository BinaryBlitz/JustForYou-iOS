//
//  BBMyProgramsRouter.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsRouterInput.h"

#import "BBMyProgramsPresenter.h"

@interface BBMyProgramsRouter : NSObject <BBMyProgramsRouterInput>

@property (weak, nonatomic) BBMyProgramsPresenter *presenter;

@end