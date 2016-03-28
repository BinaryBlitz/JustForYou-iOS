//
//  BBNavigationRouter.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationRouterInput.h"

#import "BBNavigationPresenter.h"

@interface BBNavigationRouter : NSObject <BBNavigationRouterInput>

@property (nonatomic,weak) BBNavigationPresenter *presenter;

@end