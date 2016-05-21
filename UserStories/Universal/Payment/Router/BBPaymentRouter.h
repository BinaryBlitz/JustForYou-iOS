//
//  BBPaymentRouter.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentRouterInput.h"

#import "BBPaymentPresenter.h"

@interface BBPaymentRouter : NSObject <BBPaymentRouterInput>

@property (weak, nonatomic) BBPaymentPresenter *presenter;

@end