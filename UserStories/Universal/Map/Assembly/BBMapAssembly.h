//
//  BBMapAssembly.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBMapModuleInput;

@interface BBMapAssembly : NSObject

+ (id <BBMapModuleInput>)createModule;


@end