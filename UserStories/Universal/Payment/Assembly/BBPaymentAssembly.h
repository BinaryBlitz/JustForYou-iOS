//
//  BBPaymentAssembly.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBPaymentModuleInput;

@interface BBPaymentAssembly : NSObject

+ (id <BBPaymentModuleInput>)createModule;


@end