//
//  BBMyHistoryAssembly.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBMyHistoryModuleInput;

@interface BBMyHistoryAssembly : NSObject

+ (id <BBMyHistoryModuleInput>)createModule;


@end