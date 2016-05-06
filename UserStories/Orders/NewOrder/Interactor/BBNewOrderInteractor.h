//
//  BBNewOrderInteractor.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderInteractorInput.h"

@protocol BBNewOrderInteractorOutput;

@interface BBNewOrderInteractor : NSObject <BBNewOrderInteractorInput>

@property (weak, nonatomic) id<BBNewOrderInteractorOutput> output;

@end