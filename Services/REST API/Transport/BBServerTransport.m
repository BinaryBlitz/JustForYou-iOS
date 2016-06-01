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

NSString * const kServerURL = @"https://secure-harbor-57135.herokuapp.com";


@implementation BBServerTransport

#pragma mark - Authorization Methods 

- (void)sendUserNumberPhoneWithString:(NSString *)userPhone completion:(CompletionBlock)completion {
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/verification_tokens", kServerURL]];
    
    NSDictionary* parameters = @{@"phone_number" : userPhone};
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    request.HTTPMethod = POST;
    request.HTTPBody = data;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request completion:completion];

}

#pragma mark - Sending Requests

- (void)sendRequest:(NSURLRequest *)request completion:(CompletionBlock)completion {
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completion] resume];
}

@end
