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

#import "BBValidationService.h"

@implementation BBAuthorizationInteractor

#pragma mark - Методы BBAuthorizationInteractorInput

- (void)sendNumberPhoneWithPrimaryPhone:(NSString *)primaryPhone {
     NSString *numberPhone = [BBValidationService numberPhoneWithPrimaryString:primaryPhone];
    [[BBServerService sharedService] userNumberPhoneWithString:numberPhone completion:^(BBServerServiceConnection key, NSString* token, NSError* error) {
        if (key == kSuccessfullyConnection) {
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

@end