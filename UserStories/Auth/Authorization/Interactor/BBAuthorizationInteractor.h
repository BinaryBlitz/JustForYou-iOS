//
//  BBAuthorizationInteractor.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationInteractorInput.h"

@protocol BBAuthorizationInteractorOutput;

@interface BBAuthorizationInteractor : NSObject <BBAuthorizationInteractorInput>

@property (nonatomic, weak) id<BBAuthorizationInteractorOutput> output;

@end