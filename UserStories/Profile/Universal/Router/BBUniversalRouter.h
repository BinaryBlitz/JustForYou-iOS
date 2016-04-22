//
//  BBUniversalRouter.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalRouterInput.h"

#import "BBUniversalPresenter.h"

@interface BBUniversalRouter : NSObject <BBUniversalRouterInput>

@property (weak, nonatomic) BBUniversalPresenter *presenter;

@end