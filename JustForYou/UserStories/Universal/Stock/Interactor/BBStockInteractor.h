//
//  BBStockInteractor.h
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockInteractorInput.h"

@protocol BBStockInteractorOutput;

@interface BBStockInteractor : NSObject <BBStockInteractorInput>

@property (weak, nonatomic) id<BBStockInteractorOutput> output;

@end