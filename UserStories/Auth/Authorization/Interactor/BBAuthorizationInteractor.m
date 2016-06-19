//
//  BBAuthorizationInteractor.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationInteractor.h"

#import "BBAuthorizationInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBAuthorizationInteractor

#pragma mark - Методы BBAuthorizationInteractorInput

- (void)sendNumberPhoneWithPhone:(NSString *)phone {
    [[BBServerService sharedService] userNumberPhoneWithString:phone completion:^(BBServerResponse *response, NSString* token, NSError* error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (token) {
                [self.output sendCodeSuccessfullyWithAuthToken:token];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output noConnectionNetwork];
        }
        
    }];
}

- (void)sendCodeUserWithCode:(NSString *)code numberPhone:(NSString *)phone authTiken:(NSString *)token {
    [[BBServerService sharedService] verificationUserWithNumberPhohe:phone codeSMS:code verificateToken:token completion:^(BBServerResponse *response, NSString *token, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.responseCode == kResponce200 && ([token isKindOfClass:[NSNull class]] || token == nil)) {
                [self.output codeSuccessfullyButUserMissingOnServer];
            } else if (token && [token isKindOfClass:[NSString class]]) {
                [[BBUserService sharedService] saveUserApiToken:token];
                [self.output codeSuccessfullyWithUserToken:token];
            } else if(response.serverError != kServerErrorSuccessfull) {
                [self.output errorServer];
            }
        } else {
            [self.output noConnectionNetwork];
        }
    }];
}

- (void)getUserOnServerAndSaveWithToken:(NSString *)token {
    [[BBServerService sharedService] showUserWithUserToken:token completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (user) {
                [[BBUserService sharedService] saveCurrentUser:user];
                [[BBServerService sharedService] listAddressUserWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                    [[BBUserService sharedService] addAddressUserFromArray:objects];
                    [self.output userSuccessfullAuthorizate];
                }];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output noConnectionNetwork];
        }
    }];
}

@end