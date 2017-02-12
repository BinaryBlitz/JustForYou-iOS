//
//  BBTabbarRouter.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarRouterInput.h"

#import "BBTabbarPresenter.h"

@interface BBTabbarRouter : NSObject <BBTabbarRouterInput>

@property (weak, nonatomic) BBTabbarPresenter *presenter;

@end