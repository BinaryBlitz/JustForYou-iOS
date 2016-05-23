//
//  BBServerService.m
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBServerService.h"

#import "BBServerTransport.h"

@interface BBServerService()

@property (strong, nonatomic) BBServerTransport *transport;

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




#pragma mark - Lazy Load

- (BBServerTransport *) transport {
    if (!_transport) {
        _transport = [[BBServerTransport alloc] init];
    }
    return _transport;
}


@end
