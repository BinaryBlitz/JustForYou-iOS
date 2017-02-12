//
//  BBMyProgramsInteractor.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsInteractorInput.h"

@protocol BBMyProgramsInteractorOutput;

@interface BBMyProgramsInteractor : NSObject <BBMyProgramsInteractorInput>

@property (weak, nonatomic) id<BBMyProgramsInteractorOutput> output;

@end