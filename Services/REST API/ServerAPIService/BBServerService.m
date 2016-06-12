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

#pragma mark - Blocks And Program

- (void)listBlocksWithApiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport listBlocksWithApiToken:apiToken completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        NSArray *result = nil;
        if (!error) {
            result = [data parseArrayWithDataAndKey:kTypeBlockInData parentId:0 urlServer:[self.transport HOSTServer]];
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
            result = [data parseArrayWithDataAndKey:kTypeProgramInData parentId:blockId urlServer:[self.transport HOSTServer]];
        }
        
        if (completion) {
            completion(responseServer, result, error);
        }
    }];
}

- (void)listDaysInProgramId:(NSInteger)programId apiToken:(NSString *)apiToken completion:(ArrayObjectsCompletion)completion {
    [self _checkNetworkConnection];
//    [self.transport listDaysWithApiToken:apiToken programId:[NSString stringWithFormat:@"%ld", (long)programId] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
//        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
//        NSArray *result = nil;
//        if (!error) {
//            result = [data parseArrayWithDataAndKey:kTypeDayInData parentId:programId urlServer:[self.transport HOSTServer]];
//        }
//        
//        if (completion) {
//            completion(responseServer, result, error);
//        }
//    }];
}

#pragma mark - Order Methods

- (void)createOrderWithOrders:(NSArray *)orders apiToken:(NSString *)token numberPhone:(NSString *)phone completion:(OrderCompletion)completion {
    [self _checkNetworkConnection];
    [self.transport createOrderWithOrders:orders apiToken:token numberPhone:phone completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        BBServerResponse *responseServer = [[BBServerResponse alloc] initWithResponse:response keyConnection:self.keyConnection];
        BBOrder *order = nil;
        if (!error) {
//            result = [data parseArrayWithDataAndKey:kTypeProgramInData];
        }
        
        if (completion) {
//            completion(responseServer, result, error);
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
