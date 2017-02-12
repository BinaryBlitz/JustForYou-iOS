//
//  BBBasketRouter.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketRouterInput.h"

#import "BBBasketPresenter.h"

@interface BBBasketRouter : NSObject <BBBasketRouterInput>

@property (weak, nonatomic) BBBasketPresenter *presenter;

@end