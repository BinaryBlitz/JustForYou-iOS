//
//  BBServerTransport.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSData *data, NSURLResponse* response, NSError* error);

@interface BBServerTransport : NSObject

@end
