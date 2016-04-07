//
//  BBSupportInteractor.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportInteractorInput.h"

@protocol BBSupportInteractorOutput;

@interface BBSupportInteractor : NSObject <BBSupportInteractorInput>

@property (weak, nonatomic) id<BBSupportInteractorOutput> output;

@end