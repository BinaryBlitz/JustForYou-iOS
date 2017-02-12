//
//  BBRegistrationInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBRegistrationInteractorOutput <NSObject>

- (void)userSuccessfullySaved;

- (void)noConnectionNetwork;

- (void)errorServer;


@end