//
//  BBSettingsInteractor.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsInteractorInput.h"

@protocol BBSettingsInteractorOutput;

@interface BBSettingsInteractor : NSObject <BBSettingsInteractorInput>

@property (weak, nonatomic) id<BBSettingsInteractorOutput> output;

@end