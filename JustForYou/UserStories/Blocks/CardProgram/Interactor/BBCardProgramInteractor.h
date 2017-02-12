//
//  BBCardProgramInteractor.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramInteractorInput.h"

@protocol BBCardProgramInteractorOutput;

@interface BBCardProgramInteractor : NSObject <BBCardProgramInteractorInput>

@property (weak, nonatomic) id<BBCardProgramInteractorOutput> output;

@end