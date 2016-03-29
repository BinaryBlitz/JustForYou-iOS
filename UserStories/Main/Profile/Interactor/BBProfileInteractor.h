//
//  BBProfileInteractor.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileInteractorInput.h"

@protocol BBProfileInteractorOutput;

@interface BBProfileInteractor : NSObject <BBProfileInteractorInput>

@property (weak, nonatomic) id<BBProfileInteractorOutput> output;

@end