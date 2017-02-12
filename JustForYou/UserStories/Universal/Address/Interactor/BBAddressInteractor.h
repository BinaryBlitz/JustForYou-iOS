//
//  BBAddressInteractor.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressInteractorInput.h"

@protocol BBAddressInteractorOutput;

@interface BBAddressInteractor : NSObject <BBAddressInteractorInput>

@property (weak, nonatomic) id<BBAddressInteractorOutput> output;

@end