//
//  BBReplacementInteractor.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementInteractorInput.h"

@protocol BBReplacementInteractorOutput;

@interface BBReplacementInteractor : NSObject <BBReplacementInteractorInput>

@property (weak, nonatomic) id<BBReplacementInteractorOutput> output;

@end