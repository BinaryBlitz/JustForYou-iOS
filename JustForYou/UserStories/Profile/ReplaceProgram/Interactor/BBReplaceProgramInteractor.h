//
//  BBReplaceProgramInteractor.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramInteractorInput.h"

@protocol BBReplaceProgramInteractorOutput;

@interface BBReplaceProgramInteractor : NSObject <BBReplaceProgramInteractorInput>

@property (weak, nonatomic) id<BBReplaceProgramInteractorOutput> output;

@end