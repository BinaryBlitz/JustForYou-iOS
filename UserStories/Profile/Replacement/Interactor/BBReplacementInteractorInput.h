//
//  BBReplacementInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBReplacementCategory.h"

@protocol BBReplacementInteractorInput <NSObject>

- (void)currentReplacementUser;

- (void)deleteElementInArrayWithElement:(BBReplacementProduct *)element;

- (void)addInCurrentArrayReplacementNewElement:(BBReplacementProduct *)element;

- (void)listReplacementOnServer;

@end