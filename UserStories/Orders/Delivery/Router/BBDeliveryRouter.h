//
//  BBDeliveryRouter.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryRouterInput.h"

#import "BBDeliveryPresenter.h"

@interface BBDeliveryRouter : NSObject <BBDeliveryRouterInput>

@property (weak, nonatomic) BBDeliveryPresenter *presenter;

@end