//
//  BBAuthorizationRouter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationRouterInput.h"

#import "BBAuthorizationPresenter.h"

@interface BBAuthorizationRouter : NSObject <BBAuthorizationRouterInput>

@property (nonatomic,weak) BBAuthorizationPresenter *presenter;

@end