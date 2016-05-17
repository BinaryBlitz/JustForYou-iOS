//
//  BBGreetingRouter.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingRouterInput.h"

#import "BBGreetingPresenter.h"

@interface BBGreetingRouter : NSObject <BBGreetingRouterInput>

@property (weak, nonatomic) BBGreetingPresenter *presenter;

@end