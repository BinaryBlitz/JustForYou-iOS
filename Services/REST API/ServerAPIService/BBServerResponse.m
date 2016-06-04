//
//  BBServerResponse.m
//  JustForYou
//
//  Created by Антон on 04.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBServerResponse.h"

@interface BBServerResponse ()

@property (assign, nonatomic) NSUInteger responseCode;
@property (assign, nonatomic) BBErrorServer serverError;
@property (assign, nonatomic) BBServerServiceConnection kConnectionServer;

@end

@implementation BBServerResponse

- (instancetype)initWithResponse:(NSURLResponse *)responseServer keyConnection:(BBServerServiceConnection)key {
    self = [super init];
    if (self) {
        self.serverError = [self parseServerErrorWithResponse:responseServer];
        self.kConnectionServer = key;
    }
    return self;
}

- (BBErrorServer)parseServerErrorWithResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    self.responseCode = [httpResponse statusCode];
    if (self.responseCode < 200) {
        return kServerErrorNone;
    } else if (self.responseCode >= 200 && self.responseCode < 300) {
        return kServerErrorSuccessfull;
    } else if (self.responseCode >= 400 && self.responseCode < 500) {
        return kServerErrorClient;
    } else if (self.responseCode >= 500 && self.responseCode < 600) {
        return kServerErrorServer;
    }
    return kServerErrorNone;
}

@end
