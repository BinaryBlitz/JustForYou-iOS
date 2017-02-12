//
//  BBSupportRouter.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportRouterInput.h"

#import "BBSupportPresenter.h"

@interface BBSupportRouter : NSObject <BBSupportRouterInput>

@property (weak, nonatomic) BBSupportPresenter *presenter;

@end