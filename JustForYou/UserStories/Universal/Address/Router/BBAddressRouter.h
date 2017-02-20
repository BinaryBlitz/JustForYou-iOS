#import "BBAddressRouterInput.h"

#import "BBAddressPresenter.h"

@interface BBAddressRouter : NSObject <BBAddressRouterInput>

@property (weak, nonatomic) BBAddressPresenter *presenter;

@end
