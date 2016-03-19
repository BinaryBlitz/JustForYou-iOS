//
//  BBTestAssembly.h
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBTestModuleInput;

/**
 @author tercteberc

 Test module
 */
@interface BBTestAssembly : NSObject

+ (id <BBTestModuleInput>)createModule;


@end