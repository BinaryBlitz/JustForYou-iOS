//
//  BBOrdersInteractor.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersInteractorInput.h"

@protocol BBOrdersInteractorOutput;

@interface BBOrdersInteractor : NSObject <BBOrdersInteractorInput>

@property (weak, nonatomic) id<BBOrdersInteractorOutput> output;

@end