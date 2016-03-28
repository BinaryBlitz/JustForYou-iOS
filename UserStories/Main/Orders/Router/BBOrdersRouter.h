//
//  BBOrdersRouter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersRouterInput.h"

#import "BBOrdersPresenter.h"

@interface BBOrdersRouter : NSObject <BBOrdersRouterInput>

@property (weak, nonatomic) BBOrdersPresenter *presenter;

@end