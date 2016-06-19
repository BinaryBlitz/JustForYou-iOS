//
//  BBServerTransport.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

typedef void (^CompletionBlock)(NSData *data, NSURLResponse* response, NSError* error);

@interface BBServerTransport : NSObject

- (NSString *)HOSTServer;

#pragma mark - User

- (void)sendUserNumberPhoneWithString:(NSString *)userPhone completion:(CompletionBlock)completion;
- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(CompletionBlock)completion;
- (void)createUser:(BBUser *)user completion:(CompletionBlock)completion;
- (void)showUser:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)updateUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;
- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSString *)blockId completion:(CompletionBlock)completion;
- (void)listDaysWithApiToken:(NSString *)apiToken programId:(NSString *)programId completion:(CompletionBlock)completion;

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone completion:(CompletionBlock)completion;

#pragma mark - Deliveries Methods

- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSString *)orderId apiToken:(NSString *)apiToken completion:(CompletionBlock)completion;


#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion;

#pragma mark - Geolocation

- (void)searchGeolocationWithURL:(NSURL *)url completion:(CompletionBlock)completion;

@end
