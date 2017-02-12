//
//  BBMapRouter.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapRouterInput.h"

#import "BBMapPresenter.h"

@interface BBMapRouter : NSObject <BBMapRouterInput>

@property (weak, nonatomic) BBMapPresenter *presenter;

@end