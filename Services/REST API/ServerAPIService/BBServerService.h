//
//  BBServerService.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBServerResponse.h"

@class BBUser;

typedef void (^AuthCompletion)(BBServerResponse *response, NSString* token, NSError* error);
typedef void (^RegistrationCompletion)(BBServerResponse *response, BBUser *user, NSError* error);
typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(AuthCompletion)completion;
- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)showUserWithUserToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;
- (void)updateUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;

@end
