//
//  BBNavigationInteractor.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationInteractorInput.h"

@protocol BBNavigationInteractorOutput;

@interface BBNavigationInteractor : NSObject <BBNavigationInteractorInput>

@property (nonatomic, weak) id<BBNavigationInteractorOutput> output;

@end