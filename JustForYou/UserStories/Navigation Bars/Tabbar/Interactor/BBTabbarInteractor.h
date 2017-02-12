//
//  BBTabbarInteractor.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarInteractorInput.h"

@protocol BBTabbarInteractorOutput;

@interface BBTabbarInteractor : NSObject <BBTabbarInteractorInput>

@property (weak, nonatomic) id<BBTabbarInteractorOutput> output;

@end