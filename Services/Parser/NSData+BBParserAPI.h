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

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key parentId:(NSInteger)parentId urlServer:(NSString *)url;

#pragma mark - Orders Methods

- (NSInteger)parseCreatingOrderPrograms;

#pragma mark - Deliveries Methods

- (NSArray *)parseDeliveriesWithData;

#pragma mark - Payments Methods

- (BBPayment *)parsePaymentWithData;

#pragma mark - Stock Methods

- (NSArray *)parseStocksWithData;

#pragma mark - Map Methods

- (id)parseSearchAddress;

@end
