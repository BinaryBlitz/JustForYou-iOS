//
//  BBListMyProgRouter.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgRouterInput.h"

#import "BBListMyProgPresenter.h"

@interface BBListMyProgRouter : NSObject <BBListMyProgRouterInput>

@property (weak, nonatomic) BBListMyProgPresenter *presenter;

@end