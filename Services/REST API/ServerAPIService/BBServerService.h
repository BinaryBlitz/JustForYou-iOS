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
@class BBAddress;
@class BBExchange;

typedef void (^AuthCompletion)(BBServerResponse *response, NSString *token, NSError *error);
typedef void (^RegistrationCompletion)(BBServerResponse *response, BBUser *user, NSError *error);
typedef void (^ArrayObjectsCompletion)(BBServerResponse *response, NSArray *objects, NSError *error);
typedef void (^OrderCompletion)(BBServerResponse *response, NSInteger orderId, NSError *error);
typedef void (^PaymentCompletion)(BBServerResponse *response, BBPayment *payment, NSError *error);
typedef void (^ExchangeCompletion)(BBServerResponse *response, BBExchange *exchande, NSData *data, NSError *error);
typedef void (^AddressCompletion)(BBServerResponse *response, BBAddress *address, NSError *error);
typedef void (^PaymentBoolCompletion)(BBServerResponse *response, BOOL paid, NSError *error);
typedef void (^Completion)(BBServerResponse *response, NSError *error);
typedef void (^ReceiveData)(BBServerResponse *response, NSData* data, NSError *error);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

- (NSString *)HOSTServer;

#pragma mark - User

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(AuthCompletion)completion;
- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion;
- (void)showUserWithUserToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;
- (void)updateUserWithUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(RegistrationCompletion)completion;

- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Push Methods

- (void)updateDeviceTokenWithApiToken:(NSString *)apiToken deviceToken:(NSData *)deviceToken completion:(Completion)completion;

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSInteger)blockId completion:(ArrayObjectsCompletion)completion;
- (void)listDaysInProgramId:(NSInteger)programId apiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone useBonuses:(BOOL)use completion:(OrderCompletion)completion;
- (void)listOrdersWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Deliveries Methods

- (void)checkDeliveryInvoicesWithApiToken:(NSString *)apiToken completion:(ReceiveData)completion;
- (void)cancelDeliveryWithApiToken:(NSString *)apiToken deliveryId:(NSString *)deliveryId completion:(Completion)completion;
- (void)payDeliveryInvoicesWithApiToken:(NSString *)apiToken invoicesId:(NSString *)inId cardId:(NSInteger)cardId completion:(ReceiveData)completion;
- (void)listPurchasesWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)createDeliveriesWithApiToken:(NSString *)apiToken purchId:(NSString *)purchaseId arrayDeliveries:(NSArray *)deliveries completion:(ArrayObjectsCompletion)completion;

#pragma mark - Exchanges Methods

- (void)listAllProgramsWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)createExchangesWithApiToken:(NSString *)token purchase:(NSString *)purcId program:(NSNumber *)progId completion:(ExchangeCompletion)completion;
- (void)payExchangeWithApiToken:(NSString *)apiToken exchange:(BBExchange *)exchange payId:(NSInteger)payId completion:(ReceiveData)completion;

#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSInteger)orderId apiToken:(NSString *)apiToken completion:(PaymentCompletion)completion;
- (void)createPaymentsWithPayCard:(NSInteger)cardId orderId:(NSInteger)orderId apiToken:(NSString *)apiToken
                       completion:(PaymentBoolCompletion)completion;

#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

#pragma mark - Replacement Methods

- (void)listProductsForReplasementWithToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)createReplacementWithApiToken:(NSString *)apiToken productId:(NSInteger)productId completion:(OrderCompletion)completion;
- (void)listUserReplasementWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;
- (void)deleteUserReplacementWithApiToken:(NSString *)apiToken replacementId:(NSString *)replacementId completion:(Completion)completion;

#pragma mark - Address Methods

- (void)createAddressWithApiToken:(NSString *)apiToken address:(BBAddress *)address completion:(AddressCompletion)completion;
- (void)deleteAddressWithApiToken:(NSString *)apiToken addressId:(NSString *)addressId completion:(Completion)completion;

#pragma  mark - PayCard Methods

- (void)listPaymentCardsUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion;

@end
