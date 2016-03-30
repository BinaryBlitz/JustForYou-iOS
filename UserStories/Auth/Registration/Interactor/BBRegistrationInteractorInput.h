//
//  BBRegistrationInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;
@protocol BBRegistrationInteractorInput <NSObject>

- (void)saveUser:(BBUser *)user;

@end