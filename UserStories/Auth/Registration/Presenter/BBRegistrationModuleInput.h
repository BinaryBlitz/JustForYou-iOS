//
//  BBRegistrationModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBRegistrationModuleInput <NSObject>

- (void)configureModule;

- (void)presentWithView:(id)viewController;

@end