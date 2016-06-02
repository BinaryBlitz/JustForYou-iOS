//
//  BBServerService.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kSuccessfullyConnection,
    kErrorConnection
}BBServerServiceConnection;

typedef void (^AuthCompletion)(BBServerServiceConnection key, NSString* token, NSError* error);
typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

+ (instancetype) sharedService;

- (void)userNumberPhoneWithString:(NSString *)numberPhone completion:(AuthCompletion)completion;

@end
