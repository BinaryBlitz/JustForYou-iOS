//
//  BBProfileInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;

@protocol BBProfileInteractorOutput <NSObject>

- (void)currentUserWithUser:(BBUser *)user;

@end