//
//  BBReplaceProgramInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBReplaceProgramInteractorInput <NSObject>

- (void)listAllPrograms;

- (void)createReplaceWithPurchase:(BBPurchases *)purchase program:(BBProgram *)program;
- (void)payOnServerWithPayCard:(BBPayCard *)card paiId:(NSInteger)paiId;

@end