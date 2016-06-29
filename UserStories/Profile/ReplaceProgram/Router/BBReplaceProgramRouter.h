//
//  BBReplaceProgramRouter.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramRouterInput.h"

#import "BBReplaceProgramPresenter.h"

@interface BBReplaceProgramRouter : NSObject <BBReplaceProgramRouterInput>

@property (weak, nonatomic) BBReplaceProgramPresenter *presenter;

@end