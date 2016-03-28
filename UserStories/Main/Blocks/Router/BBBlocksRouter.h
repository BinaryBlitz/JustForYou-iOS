//
//  BBBlocksRouter.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksRouterInput.h"

#import "BBBlocksPresenter.h"

@interface BBBlocksRouter : NSObject <BBBlocksRouterInput>

@property (weak, nonatomic) BBBlocksPresenter *presenter;

@end