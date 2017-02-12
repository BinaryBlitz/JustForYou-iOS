//
//  BBRegistrationRouter.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationRouterInput.h"

#import "BBRegistrationPresenter.h"

@interface BBRegistrationRouter : NSObject <BBRegistrationRouterInput>

@property (weak, nonatomic) BBRegistrationPresenter *presenter;

@end