//
//  BBUniversalInteractor.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalInteractorInput.h"

@protocol BBUniversalInteractorOutput;

@interface BBUniversalInteractor : NSObject <BBUniversalInteractorInput>

@property (weak, nonatomic) id<BBUniversalInteractorOutput> output;

@end