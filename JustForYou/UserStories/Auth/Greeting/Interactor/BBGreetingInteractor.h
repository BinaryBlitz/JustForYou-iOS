//
//  BBGreetingInteractor.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingInteractorInput.h"

@protocol BBGreetingInteractorOutput;

@interface BBGreetingInteractor : NSObject <BBGreetingInteractorInput>

@property (weak, nonatomic) id<BBGreetingInteractorOutput> output;

@end