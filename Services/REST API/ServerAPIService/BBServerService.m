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

- (void)updateUserWithUser:(BBUser *)user completion:(RegistrationCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport updateUser:user completion:^(NSData *data, NSURLResponse *response, NSError *error) {
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

#pragma mark - Orders

//- (void)createOrderWithOrders:(NSArray *)orders completion{
//    
//}


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
