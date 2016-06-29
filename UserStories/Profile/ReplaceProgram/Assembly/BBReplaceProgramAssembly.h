//
//  BBReplaceProgramAssembly.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplaceProgramModuleInput;

@interface BBReplaceProgramAssembly : NSObject

+ (id <BBReplaceProgramModuleInput>)createModule;


@end