//
//  BBAuthorizationInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAuthorizationInteractorInput <NSObject>

- (void)sendNumberPhoneWithPhone:(NSString *)phone;

- (void)sendCodeUserWithCode:(NSString *)code numberPhone:(NSString *)phone authTiken:(NSString *)token;

- (void)getUserOnServerAndSaveWithToken:(NSString *)token;

@end