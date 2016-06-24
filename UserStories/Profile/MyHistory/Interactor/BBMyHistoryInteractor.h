//
//  BBMyHistoryInteractor.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryInteractorInput.h"

@protocol BBMyHistoryInteractorOutput;

@interface BBMyHistoryInteractor : NSObject <BBMyHistoryInteractorInput>

@property (weak, nonatomic) id<BBMyHistoryInteractorOutput> output;

@end