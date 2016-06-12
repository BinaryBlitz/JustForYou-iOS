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

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/orders", kServerURL]];
    
    NSDictionary* parameters = @{@"api_token"             : token,
                                 @"phone_number"          : phone,
                                 @"line_items_attributes" : orders};
    request = [self _settingRequestWithRequest:request parametrs:parameters HTTPMethod:POST];
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
