//
//  BBMapInteractor.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapInteractorInput.h"

@protocol BBMapInteractorOutput;

@interface BBMapInteractor : NSObject <BBMapInteractorInput>

@property (weak, nonatomic) id<BBMapInteractorOutput> output;

@end