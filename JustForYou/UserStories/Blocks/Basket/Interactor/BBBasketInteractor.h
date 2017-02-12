//
//  BBBasketInteractor.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketInteractorInput.h"

@protocol BBBasketInteractorOutput;

@interface BBBasketInteractor : NSObject <BBBasketInteractorInput>

@property (weak, nonatomic) id<BBBasketInteractorOutput> output;

@end