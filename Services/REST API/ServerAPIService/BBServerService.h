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
@class BBPayment;
@class BBPayCard;

typedef void (^AuthCompletion)(BBServerResponse *response, NSString *token, NSError *error);
typedef void (^RegistrationCompletion)(BBServerResponse *response, BBUser *user, NSError *error);

typedef void (^ArrayObjectsCompletion)(BBServerResponse *response, NSArray *objects, NSError *error);

typedef void (^OrderCompletion)(BBServerResponse *response, NSInteger orderId, NSError *error);
typedef void (^PaymentCompletion)(BBServerResponse *response, BBPayment *payment, NSError *error);
typedef void (^PaymentBoolCompletion)(BBServerResponse *response, BOOL paid, NSError *error) ;

typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

#pragma mark - User

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(AuthCompletion)completion;
- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)showUserWithUserToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;
- (void)updateUserWithUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;

- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSInteger)blockId completion:(ArrayObjectsCompletion)completion;
- (void)listDaysInProgramId:(NSInteger)programId apiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone completion:(OrderCompletion)completion;

#pragma mark - Deliveries Methods

- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
//- (void)createDeliveriesWithApiToken:(NSString *)apiToken arrayDeliveries:(NSArray *)deliveries;

#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSInteger)orderId apiToken:(NSString *)apiToken completion:(PaymentCompletion)completion;
- (void)createPaymentsWithPayCard:(NSInteger)cardId orderId:(NSInteger)orderId apiToken:(NSString *)apiToken
                       completion:(PaymentBoolCompletion)completion;

#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma  mark - PayCard Methods

- (void)listPaymentCardsUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

@end
