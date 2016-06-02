//
//  BBServerTransport.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

typedef void (^CompletionBlock)(NSData *data, NSURLResponse* response, NSError* error);

@interface BBServerTransport : NSObject

- (void)sendUserNumberPhoneWithString:(NSString *)userPhone completion:(CompletionBlock)completion;

- (void)sendUser:(BBUser *)user completion:(CompletionBlock)completion;

- (void)searchGeolocationWithURL:(NSURL *)url completion:(CompletionBlock)completion;

@end
