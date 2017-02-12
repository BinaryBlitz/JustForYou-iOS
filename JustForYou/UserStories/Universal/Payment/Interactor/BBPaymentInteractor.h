//
//  BBPaymentInteractor.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentInteractorInput.h"

@protocol BBPaymentInteractorOutput;

@interface BBPaymentInteractor : NSObject <BBPaymentInteractorInput>

@property (weak, nonatomic) id<BBPaymentInteractorOutput> output;

@end