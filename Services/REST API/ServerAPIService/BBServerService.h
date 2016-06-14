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
@class BBOrder;

typedef void (^AuthCompletion)(BBServerResponse *response, NSString* token, NSError* error);
typedef void (^RegistrationCompletion)(BBServerResponse *response, BBUser *user, NSError* error);

typedef void (^ArrayObjectsCompletion)(BBServerResponse *response, NSArray *objects, NSError* error);

typedef void (^OrderCompletion)(BBServerResponse *response, NSInteger orderId, NSError* error);

typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

#pragma mark - User

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(AuthCompletion)completion;
- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)showUserWithUserToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;
- (void)updateUserWithUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSInteger)blockId completion:(ArrayObjectsCompletion)completion;
- (void)listDaysInProgramId:(NSInteger)programId apiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone completion:(OrderCompletion)completion;

@end
