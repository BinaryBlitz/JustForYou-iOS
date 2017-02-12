//
//  BBProfileRouter.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileRouterInput.h"

#import "BBProfilePresenter.h"

@interface BBProfileRouter : NSObject <BBProfileRouterInput>

@property (weak, nonatomic) BBProfilePresenter *presenter;

@end