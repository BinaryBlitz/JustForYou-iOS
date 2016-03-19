//
//  BBTestRouter.h
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestRouterInput.h"

#import "BBTestPresenter.h"

@interface BBTestRouter : NSObject <BBTestRouterInput>

@property (nonatomic,weak) BBTestPresenter *presenter;

@end