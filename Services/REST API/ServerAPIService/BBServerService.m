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
        NSString *token = nil;
        if (!error) {
            token = [data parseAuthorizateToken];
        }
        if (completion) {
            completion(self.keyConnection, token, error);
        }
    }];
}

#warning DELETE

- (void)searchCoordinatesForURLString:(NSString *)urlString {
    
   
    
    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    if (data) {
//        id jsonString = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        //JSON Framework magic to obtain a dictionary from the jsonString.
//        
//        
//        //Now we need to obtain our coordinates
//        NSArray *placemark  = [jsonString objectForKey:@"Placemark"];
//        NSArray *coordinates = [[placemark objectAtIndex:0] valueForKeyPath:@"Point.coordinates"];
//        
//        //I put my coordinates in my array.
//        double longitude = [[coordinates objectAtIndex:0] doubleValue];
//        double latitude = [[coordinates objectAtIndex:1] doubleValue];
//    }
    
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
