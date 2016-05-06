//
//  BBNewOrderRouter.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderRouterInput.h"

#import "BBNewOrderPresenter.h"

@interface BBNewOrderRouter : NSObject <BBNewOrderRouterInput>

@property (weak, nonatomic) BBNewOrderPresenter *presenter;

@end