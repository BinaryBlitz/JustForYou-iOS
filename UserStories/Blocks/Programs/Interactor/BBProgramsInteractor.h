//
//  BBProgramsInteractor.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsInteractorInput.h"

@protocol BBProgramsInteractorOutput;

@interface BBProgramsInteractor : NSObject <BBProgramsInteractorInput>

@property (weak, nonatomic) id<BBProgramsInteractorOutput> output;

@end