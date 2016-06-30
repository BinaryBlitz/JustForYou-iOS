//
//  NSData+BBParserAPI.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"
#import "BBPayment.h"
#import "BBAddress.h"
#import "BBStock.h"
#import "BBPayCard.h"
#import "BBReplacementCategory.h"
#import "BBPurchases.h"
#import "BBProgramHistory.h"
#import "BBExchange.h"

typedef enum : NSUInteger {
    kTypeBlockInData,
    kTypeProgramInData,
    kTypeDayInData
}BBTypeObjectInData;


@interface NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken;
- (NSString *)parseApiToken;

- (BBUser *)parseRegisterResponseWithData;

- (NSArray *)parseUserAddressWithData;

#pragma mark - Blocks And Program Methods

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key parentId:(NSInteger)parentId;

#pragma mark - Orders Methods

- (NSInteger)parseCreatingOrderPrograms;
- (NSArray *)parseOrderListWithData;

#pragma mark - Deliveries Methods

- (NSArray *)parsePurchasesWithData;
- (NSArray *)parseDeliveriesWithData;

#pragma mark - Payments Methods

- (BBPayment *)parsePaymentWithData;
- (BOOL)parsePaymentInCardWithData;

#pragma mark - Stock Methods

- (NSArray *)parseStocksWithData;

#pragma  mark - PayCard Methods

- (NSArray *)parsePaymentsCardUserWithData;

#pragma mark - Replacement Methods

- (NSArray *)parseProductsForReplacementWithData;
- (NSArray *)parseUserReplacementWithData;

#pragma mark - Exchanges Methods

- (NSArray *)parseAllProgramsWithData;
- (BBExchange *)parseExchangeWithData;

#pragma mark - Address Methods

- (BBAddress *)parseAddressWithData;

#pragma mark - Map Methods

- (id)parseSearchAddress;

@end
