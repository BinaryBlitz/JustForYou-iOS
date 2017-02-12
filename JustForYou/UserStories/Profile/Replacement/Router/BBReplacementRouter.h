//
//  BBReplacementRouter.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementRouterInput.h"

#import "BBReplacementPresenter.h"

@interface BBReplacementRouter : NSObject <BBReplacementRouterInput>

@property (weak, nonatomic) BBReplacementPresenter *presenter;

@end