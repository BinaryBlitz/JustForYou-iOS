//
//  BBReplacementInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplacementInteractorInput <NSObject>

- (void)currentReplacementUser;

- (void)deleteElementInArrayWithElement:(NSString *)element;

- (void)addInCurrentArrayReplacementNewElement:(NSString *)element;

@end