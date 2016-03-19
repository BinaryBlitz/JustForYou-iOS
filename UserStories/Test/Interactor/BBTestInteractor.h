//
//  BBTestInteractor.h
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestInteractorInput.h"

@protocol BBTestInteractorOutput;

@interface BBTestInteractor : NSObject <BBTestInteractorInput>

@property (nonatomic, weak) id<BBTestInteractorOutput> output;

@end