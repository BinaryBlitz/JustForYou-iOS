//
//  BBOrdersInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBOrdersInteractorOutput <NSObject>

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName;

@end