//
//  BBServerService.m
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBServerService.h"

#import "BBServerTransport.h"

#import "NSData+BBParserAPI.h"

#import "Reachability.h"

@interface BBServerService()

@property (strong, nonatomic) Reachability *internetReachable;
@property (strong, nonatomic) BBServerTransport *transport;
@property (assign, nonatomic) BBServerServiceConnection keyConnection;

@end

@implementation BBServerService

+ (instancetype) sharedService {
    static BBServerService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BBServerService alloc] init];
    });
    return service;
}

#pragma mark - Authorizate Methods

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport sendUserNumberPhoneWithString:numberPhone completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        
        NSString *token = nil;
        if (!error) {
            token = [data parseAuthorizateToken];
        }
        
        if (completion) {
            completion(responseServer, token, error);
        }
    }];
}

- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(AuthCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport verificationUserWithNumberPhohe:phone codeSMS:code verificateToken:token completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        
        NSString *token = nil;
        if (!error) {
            token = [data parseApiToken];
        }
        
        if (completion) {
            completion(responseServer, token, error);
        }
    }];
}

- (void)createUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createUser:user completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        
        BBUser *user = nil;
        
        if (!error) {
            user = [data parseRegisterResponseWithData];
        }
        
        if (completion) {
            completion(responseServer, user, error);
        }
    }];
}

- (void)showUserWithUserToken:(NSString *)apiToken completion:(RegistrationCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport showUser:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        
        BBUser *user = nil;
        if (!error) {
            user = [data parseRegisterResponseWithData];
        }
        if (completion) {
            completion(responseServer, user, error);
        }
    }];
}

- (void)updateUserWithUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(RegistrationCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport updateUser:user apiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        if (completion) {
            completion(responseServer, user, error);
        }
    }];
}


- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listAddressUserWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseUserAddressWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

#pragma mark - Push Methods

- (void)updateDeviceTokenWithApiToken:(NSString *)apiToken deviceToken:(NSData *)deviceToken completion:(Completion)completion {
    [self _checkNetworkConnection];
    [self.transport updateDeviceTokenWithApiToken:apiToken deviceToken:deviceToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        
        if (completion) {
            completion(responseServer, error);
        }
    }];
}

#pragma mark - Blocks And Program

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listBlocksWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseArrayWithDataAndKey:kTypeBlockInData parentId:0];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}


- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSInteger)blockId completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listProgramsWithApiToken:apiToken blockId:[NSString stringWithFormat:@"%ld", (long)blockId] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseArrayWithDataAndKey:kTypeProgramInData parentId:blockId];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

- (void)listDaysInProgramId:(NSInteger)programId apiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listDaysWithApiToken:apiToken programId:[NSString stringWithFormat:@"%ld", (long)programId] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseArrayWithDataAndKey:kTypeDayInData parentId:programId];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone useBonuses:(BOOL)use completion:(OrderCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createOrderWithOrders:orders apiToken:token numberPhone:phone useBonuses:use completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSInteger orderId = 0;
        if (!error) {
            orderId = [data parseCreatingOrderPrograms];
        }
        
        if (completion) {
            completion(responseServer, orderId, error);
        }
    }];
}

- (void)listOrdersWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listOrdersWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseOrderListWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}


#pragma mark - Deliveries Methods

- (void)checkDeliveryInvoicesWithApiToken:(NSString *)apiToken completion:(ReceiveData)completion {
    [self _checkNetworkConnection];
    [self.transport checkDeliveryInvoicesWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        if (completion) {
            completion(responseServer, data, error);
        }
    }];
}

- (void)payDeliveryInvoicesWithApiToken:(NSString *)apiToken invoicesId:(NSString *)inId completion:(ReceiveData)completion {
    [self _checkNetworkConnection];
    [self.transport payDeliveryInvoicesWithApiToken:apiToken
                                         invoicesId:inId
                                         completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                             BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
                                             if (completion) {
                                                 completion(responseServer, data, error);
                                             }
    }];
}

- (void)listPurchasesWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listPurchasesWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parsePurchasesWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }

    }];
}

- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listDeliveriesWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseDeliveriesWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }

    }];
}

- (void)createDeliveriesWithApiToken:(NSString *)apiToken purchId:(NSString *)purchaseId arrayDeliveries:(NSArray *)deliveries completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createDeliveriesWithApiToken:apiToken purchId:purchaseId arrayDeliveries:deliveries completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseDeliveriesWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSInteger)orderId apiToken:(NSString *)apiToken completion:(PaymentCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createPaymentsWithOrderId:[NSString stringWithFormat:@"%ld", (long)orderId] apiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        BBPayment *payment = nil;
        if (!error) {
            payment = [data parsePaymentWithData];
        }
        
        if (completion) {
            completion(responseServer, payment, error);
        }        
    }];
}

- (void)createPaymentsWithPayCard:(NSInteger)cardId orderId:(NSInteger)orderId apiToken:(NSString *)apiToken completion:(PaymentBoolCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createPaymentsWithPayCard:cardId orderId:[NSString stringWithFormat:@"%ld", (long)orderId] apiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        BOOL payment = NO;
        if (!error) {
            payment = [data parsePaymentInCardWithData];
        }
        
        if (completion) {
            completion(responseServer, payment, error);
        }
    }];
}


#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listStocksWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseStocksWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}


#pragma mark - Replacement Methods

- (void)listProductsForReplasementWithToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listProductsForReplasementWithToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseProductsForReplacementWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

- (void)createReplacementWithApiToken:(NSString *)apiToken productId:(NSInteger)productId completion:(OrderCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createReplacementWithApiToken:apiToken productId:[NSString stringWithFormat:@"%ld", (long)productId] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSInteger prodId = 0;
        if (!error) {
            prodId = [data parseCreatingOrderPrograms];
        }
        if (completion) {
            completion(responseServer, prodId, error);
        }
    }];
}

- (void)listUserReplasementWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listUserReplasementWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseUserReplacementWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

- (void)deleteUserReplacementWithApiToken:(NSString *)apiToken replacementId:(NSString *)replacementId completion:(Completion)completion {
    [self _checkNetworkConnection];
    [self.transport deleteUserReplacementWithApiToken:apiToken replacementId:replacementId completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        if (completion) {
            completion(responseServer, error);
        }
    }];
}

#pragma mark - Exchanges Methods

- (void)listAllProgramsWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listAllProgramsWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseAllProgramsWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

- (void)createExchangesWithApiToken:(NSString *)token purchase:(NSString *)purcId program:(NSNumber *)progId completion:(ExchangeCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createExchangesWithApiToken:token purchase:purcId program:progId completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        BBExchange *exchange = nil;
        if (!error) {
            exchange = [data parseExchangeWithData];
        }
        if (completion) {
            completion(responseServer, exchange, error);
        }
    }];
}

- (void)payExchangeWithApiToken:(NSString *)apiToken exchange:(BBExchange *)exchange completion:(ReceiveData)completion {
    [self _checkNetworkConnection];
    [self.transport payExchangeWithApiToken:apiToken exchange:exchange completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        if (completion) {
            completion(responseServer, data, error);
        }
    }];
}

#pragma mark - Address Methods


- (void)createAddressWithApiToken:(NSString *)apiToken address:(BBAddress *)address completion:(AddressCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createAddressWithApiToken:apiToken address:address completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        BBAddress *result = nil;
        if (!error) {
            result = [data parseAddressWithData];
        }

        if (completion) {
            completion(responseServer, result, error);
        }
        
    }];
}

- (void)deleteAddressWithApiToken:(NSString *)apiToken addressId:(NSString *)addressId completion:(Completion)completion {
    [self _checkNetworkConnection];
    [self.transport deleteAddressWithApiToken:apiToken addressId:addressId completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        if (completion) {
            completion(responseServer, error);
        }
    }];
}


#pragma  mark - PayCard Methods

- (void)listPaymentCardsUserWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listPaymentCardsUserWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parsePaymentsCardUserWithData];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

#pragma mark - Check Network

- (void)_checkNetworkConnection {
    NetworkStatus internetStatus = [self.internetReachable currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        self.keyConnection = kErrorConnection;
    } else {
        self.keyConnection = kSuccessfullyConnection;
    }
}

#pragma mark - Lazy Load

- (BBServerTransport *) transport {
    if (!_transport) {
        _transport = [[BBServerTransport alloc] init];
    }
    return _transport;
}

- (Reachability *)internetReachable {
    if (!_internetReachable) {
        _internetReachable = [Reachability reachabilityForInternetConnection];
    }
    return _internetReachable;
}


@end
