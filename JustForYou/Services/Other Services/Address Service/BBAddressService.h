#import <Foundation/Foundation.h>

#import <LMAddress.h>
#import "BBAddress.h"

typedef void (^CompletionArray)(NSArray *array);

@interface BBAddressService : NSObject

+ (instancetype)sharedService;

- (NSString *)currentApiKeyMap;

- (void)searchGeopositionForAddress:(NSString *)address completion:(CompletionArray)completion;

- (BBAddress *)addressFromAddress:(LMAddress *)addr;

- (NSArray *)arrayAddressFromSearchAddress:(id)geoposition;

@end
