//
//  BBReplacementInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplacementInteractorOutput <NSObject>

- (void)currentReplacementInData:(NSArray *)replacement;

- (void)currentReplacementUpdate;

- (void)elemetnDidDeleteWithNewArray:(NSArray *)array;

- (void)replacementCategoryInArray:(NSArray *)categories;

- (void)errorNetwork;
- (void)errorServer;

@end