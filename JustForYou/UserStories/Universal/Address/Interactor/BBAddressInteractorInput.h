#import <Foundation/Foundation.h>

@protocol BBAddressInteractorInput <NSObject>

- (void)addAddressToUserAddressArrayWithAddressText:(BBAddress *)address;

@end
