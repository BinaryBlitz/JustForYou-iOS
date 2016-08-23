//
//  BBAddressAssembly.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAddressModuleInput;

@interface BBAddressAssembly : NSObject

+ (id <BBAddressModuleInput>)createModule;


@end