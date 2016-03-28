//
//  BBBlocksInteractor.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksInteractorInput.h"

@protocol BBBlocksInteractorOutput;

@interface BBBlocksInteractor : NSObject <BBBlocksInteractorInput>

@property (weak, nonatomic) id<BBBlocksInteractorOutput> output;

@end