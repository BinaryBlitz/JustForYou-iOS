//
//  BBAddressService.h
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LMAddress.h>
#import "BBAddress.h"


typedef void (^CompletionArray)(NSArray *array);

@interface BBAddressService : NSObject

+ (instancetype) sharedService;

- (NSString *)currentApiKeyMap;

- (void)searchGeopositionForAddress:(NSString *)address completion:(CompletionArray)completion;

- (BBAddress *)addressFromAddress:(LMAddress *)addr;

- (NSArray *)arrayAddressFromSearchAddress:(id)geoposition;

@end
