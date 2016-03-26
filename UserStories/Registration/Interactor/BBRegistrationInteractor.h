//
//  BBRegistrationInteractor.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationInteractorInput.h"

@protocol BBRegistrationInteractorOutput;

@interface BBRegistrationInteractor : NSObject <BBRegistrationInteractorInput>

@property (nonatomic, weak) id<BBRegistrationInteractorOutput> output;

@end