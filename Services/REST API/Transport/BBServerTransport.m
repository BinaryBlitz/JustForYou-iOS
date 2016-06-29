//
//  BBServerTransport.m
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBServerTransport.h"

NSString * const GET = @"GET";
NSString * const PUT = @"PUT";
NSString * const POST = @"POST";
NSString * const PATCH = @"PATCH";
NSString * const DELETE = @"DELETE";

NSString * const kServerURL = @"https://justforyou-staging.herokuapp.com";

@interface BBServerTransport () <NSURLConnectionDelegate>

@end

@implementation BBServerTransport

- (NSString *)HOSTServer {
    return kServerURL;
}

#pragma mark - User Methods 

- (void)sendUserNumberPhoneWithString:(NSString *)userPhone completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/verification_tokens", kServerURL]];
    
    NSDictionary* parameters = @{@"phone_number" : userPhone};
    
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)verificationUserWithNumberPhohe:(NSString *)phone codeSMS:(NSString *)code verificateToken:(NSString *)token completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/verification_tokens/%@", kServerURL, token]];
    
    NSDictionary* parameters = @{@"phone_number" : phone,
                                 @"code"         : code};
    
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:PATCH];
    [self sendRequest:request completion:completion];
}

- (void)createUser:(BBUser *)user completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user", kServerURL]];
    NSDictionary *userDict = @{@"phone_number" : user.numberPhone,
                               @"first_name"   : user.name,
                               @"last_name"    : user.surname,
                               @"email"        : user.email};
    
    NSDictionary* parameters = @{@"user" : userDict};
    
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)showUser:(NSString *)apiToken completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)updateUser:(BBUser *)user apiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user", kServerURL]];
    
    NSDictionary* parameters = @{@"api_token"    : apiToken,
                                 @"phone_number" : user.numberPhone,
                                 @"first_name"   : user.name,
                                 @"last_name"    : user.surname,
                                 @"email"        : user.email};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:PATCH];
    [self sendRequest:request completion:completion];
}

#pragma mark - Push Methods

- (void)updateDeviceTokenWithApiToken:(NSString *)apiToken deviceToken:(NSData *)deviceToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/user", kServerURL]];
    
    NSDictionary *parametrs;
    if (deviceToken) {
        NSString * deviceTokenString = [[[[deviceToken description]
                                          stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                                        stringByReplacingOccurrencesOfString: @" " withString: @""];
        
        //    NSString* newStr = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
        
        NSDictionary *user = @{@"device_token" : deviceTokenString};
        
        parametrs = @{@"api_token"    : apiToken,
                      @"user"         : user};
    } else {
        parametrs = @{@"api_token"    : apiToken};
    }
    request = [self _settingRequestWithRequest:request parametrs:parametrs HTTPMethod:PATCH];
    [self sendRequest:request completion:completion];
}

#pragma mark - Blocks And Programs

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/blocks?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)listProgramsWithApiToken:(NSString *)apiToken blockId:(NSString *)blockId completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/blocks/%@/programs?api_token=%@", kServerURL, blockId, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)listDaysWithApiToken:(NSString *)apiToken programId:(NSString *)programId completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/programs/%@/days?api_token=%@", kServerURL, programId, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone useBonuses:(BOOL)use completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/orders", kServerURL]];
    
    NSMutableArray *array = [NSMutableArray array];
    for (BBOrderProgram *ord in orders) {
        NSNumber *numb1 = [NSNumber numberWithInteger:ord.programId];
        NSNumber *numb2 = [NSNumber numberWithInteger:ord.countDays];
        NSDictionary *par = @{@"program_id"     : numb1,
                              @"number_of_days" : numb2};
        [array addObject:par];
    }
    NSDictionary* parameters = @{@"phone_number"          : phone,
                                 @"use_balance"           : [NSNumber numberWithBool:use],
                                 @"line_items_attributes" : array};
    NSDictionary *param = @{@"api_token" : token,
                            @"order" : parameters};
    request = [self _settingRequestWithRequest:request parametrs:param HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}


- (void)listOrdersWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/orders?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

#pragma mark - Deliveries Methods

- (void)checkDeliveryInvoicesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/delivery_invoices?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)payDeliveryInvoicesWithApiToken:(NSString *)apiToken invoicesId:(NSString *)inId completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString
                                        stringWithFormat:@"%@//api/delivery_invoices/%@/payment?api_token=%@", kServerURL, inId, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)listPurchasesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/purchases?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)listDeliveriesWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/deliveries?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


- (void)createDeliveriesWithApiToken:(NSString *)apiToken purchId:(NSString *)purchaseId arrayDeliveries:(NSArray *)deliveries completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/purchases/%@/deliveries", kServerURL, purchaseId]];
    
    NSDictionary* parameters = @{@"api_token"  : apiToken,
                                 @"deliveries" : deliveries};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

#pragma mark - Exchanges Methods

- (void)listAllProgramsWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/programs?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


#pragma mark - Payments Methods

- (void)createPaymentsWithOrderId:(NSString *)orderId apiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/orders/%@/payment", kServerURL, orderId]];
    
    NSDictionary* parameters = @{@"api_token" : apiToken};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)createPaymentsWithPayCard:(NSInteger)cardId orderId:(NSString *)orderId apiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/orders/%@/payment", kServerURL, orderId]];
    
    NSDictionary *cardDict = @{@"payment_card_id" : [NSNumber numberWithInteger:cardId]};
    NSDictionary* parameters = @{@"api_token" : apiToken,
                                 @"payment"   : cardDict};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

#pragma mark - Stock Methods

- (void)listStocksWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/promotions?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


#pragma  mark - PayCard Methods

- (void)listPaymentCardsUserWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/payment_cards?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


#pragma mark - Replacement Methods

- (void)listProductsForReplasementWithToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/product_types?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)createReplacementWithApiToken:(NSString *)apiToken productId:(NSString *)productId completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/products/%@/substitutions", kServerURL, productId]];
    
    NSDictionary* parameters = @{@"api_token" : apiToken};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)listUserReplasementWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/substitutions?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}


- (void)deleteUserReplacementWithApiToken:(NSString *)apiToken replacementId:(NSString *)replacementId completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/substitutions/%@?api_token=%@", kServerURL, replacementId, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:DELETE];
    [self sendRequest:request completion:completion];
}

#pragma mark - Address Methods

- (void)listAddressUserWithApiToken:(NSString *)apiToken completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/addresses?api_token=%@", kServerURL, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:GET];
    [self sendRequest:request completion:completion];
}

- (void)createAddressWithApiToken:(NSString *)apiToken address:(BBAddress *)address completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/addresses", kServerURL]];
    
    NSDictionary *adr = @{@"content"   : address.address,
                          @"latitude"  : [NSNumber numberWithDouble:address.coordinate.latitude],
                          @"longitude"  : [NSNumber numberWithDouble:address.coordinate.longitude]};
    NSDictionary* parameters = @{@"api_token" : apiToken,
                                 @"address"   : adr};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
    [self sendRequest:request completion:completion];
}

- (void)deleteAddressWithApiToken:(NSString *)apiToken addressId:(NSString *)addressId completion:(CompletionBlock)completion {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/addresses/%@?api_token=%@", kServerURL, addressId, apiToken]];
    
    request = [self _settingRequestWithRequest:request parametrs:nil HTTPMethod:DELETE];
    [self sendRequest:request completion:completion];
}

#pragma mark - Geolocation

- (void)searchGeolocationWithURL:(NSURL *)url completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = GET;
    [self sendRequest:request completion:completion];
}



#pragma mark - Sending Requests

- (NSMutableURLRequest *)_settingRequestWithRequest:(NSMutableURLRequest *)request parametrs:(NSDictionary *)params HTTPMethod:(NSString *)http {
    if (params) {
        NSData* data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        request.HTTPBody = data;
    }
    request.HTTPMethod = http;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return request;
}

- (void)sendRequest:(NSURLRequest *)request completion:(CompletionBlock)completion {
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completion] resume];
}

@end
