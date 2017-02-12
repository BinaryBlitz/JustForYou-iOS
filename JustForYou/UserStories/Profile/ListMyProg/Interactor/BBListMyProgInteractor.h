//
//  BBListMyProgInteractor.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgInteractorInput.h"

@protocol BBListMyProgInteractorOutput;

@interface BBListMyProgInteractor : NSObject <BBListMyProgInteractorInput>

@property (weak, nonatomic) id<BBListMyProgInteractorOutput> output;

@end