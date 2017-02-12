//
//  BBSettingsRouter.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsRouterInput.h"

#import "BBSettingsPresenter.h"

@interface BBSettingsRouter : NSObject <BBSettingsRouterInput>

@property (weak, nonatomic) BBSettingsPresenter *presenter;

@end