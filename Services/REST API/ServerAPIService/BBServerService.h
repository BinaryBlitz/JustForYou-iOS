//
//  BBServerService.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;

typedef enum : NSUInteger {
    kSuccessfullyConnection,
    kErrorConnection
}BBServerServiceConnection;

typedef void (^AuthCompletion)(BBServerServiceConnection key, NSString* token, NSError* error);
typedef void (^RegistrationCompletion)(BBServerServiceConnection key, BBUser *user, NSError* error);
typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;

- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)showUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)updateUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;

@end
