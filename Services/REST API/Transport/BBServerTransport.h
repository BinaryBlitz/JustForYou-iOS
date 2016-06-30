//
//  BBServerTransport.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"
#import "BBPayCard.h"
#import "BBExchange.h"

typedef void (^CompletionBlock)(NSData *data, NSURLResponse* response, NSError* error);

@interface BBServerTransport : NSObject

- (NSString *)HOSTServer;

#pragma mark - User

- (void)sendUserNumberPhoneWithString:(NSString *)userPhone completion:(CompletionBlock)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(CompletionBlock)completion;
- (void)createUser:(BBUser *)user completion:(CompletionBlock)completion;
- (void)showUser:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)updateUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Push Methods

- (void)updateDeviceTokenWithApiToken:(NSString *)apiToken deviceToken:(NSData *)deviceToken completion:(CompletionBlock)completion;

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSString *)blockId completion:(CompletionBlock)completion;
- (void)listDaysWithApiToken:(NSString *)apiToken programId:(NSString *)programId completion:(CompletionBlock)completion;

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone useBonuses:(BOOL)use completion:(CompletionBlock)completion;
- (void)listOrdersWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Deliveries Methods

- (void)checkDeliveryInvoicesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)payDeliveryInvoicesWithApiToken:(NSString *)apiToken invoicesId:(NSString *)inId completion:(CompletionBlock)completion;
- (void)listPurchasesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)createDeliveriesWithApiToken:(NSString *)apiToken purchId:(NSString *)purchaseId arrayDeliveries:(NSArray *)deliveries completion:(CompletionBlock)completion;

#pragma mark - Exchanges Methods

- (void)listAllProgramsWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)createExchangesWithApiToken:(NSString *)token purchase:(NSString *)purcId program:(NSNumber *)progId completion:(CompletionBlock)completion;
- (void)payExchangeWithApiToken:(NSString *)apiToken exchange:(BBExchange *)exchang completion:(CompletionBlock)completion;

#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSString *)orderId apiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)createPaymentsWithPayCard:(NSInteger)cardId orderId:(NSString *)orderId apiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;


#pragma  mark - PayCard Methods

- (void)listPaymentCardsUserWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;


#pragma mark - Replacement Methods

- (void)listProductsForReplasementWithToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)createReplacementWithApiToken:(NSString *)apiToken productId:(NSString *)productId completion:(CompletionBlock)completion;
- (void)listUserReplasementWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)deleteUserReplacementWithApiToken:(NSString *)apiToken replacementId:(NSString *)replacementId completion:(CompletionBlock)completion;

#pragma mark - Address Methods

- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)createAddressWithApiToken:(NSString *)apiToken address:(BBAddress *)address completion:(CompletionBlock)completion;
- (void)deleteAddressWithApiToken:(NSString *)apiToken addressId:(NSString *)addressId completion:(CompletionBlock)completion;

#pragma mark - Geolocation

- (void)searchGeolocationWithURL:(NSURL *)url completion:(CompletionBlock)completion;

@end
