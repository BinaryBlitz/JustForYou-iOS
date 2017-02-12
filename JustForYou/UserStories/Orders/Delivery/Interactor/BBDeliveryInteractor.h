//
//  BBDeliveryInteractor.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryInteractorInput.h"

@protocol BBDeliveryInteractorOutput;

@interface BBDeliveryInteractor : NSObject <BBDeliveryInteractorInput>

@property (weak, nonatomic) id<BBDeliveryInteractorOutput> output;

@end