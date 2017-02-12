//
//  BBAddressRouter.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressRouterInput.h"

#import "BBAddressPresenter.h"

@interface BBAddressRouter : NSObject <BBAddressRouterInput>

@property (weak, nonatomic) BBAddressPresenter *presenter;

@end