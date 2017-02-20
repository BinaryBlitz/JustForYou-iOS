#import "BBDeliveryRouterInput.h"

#import "BBDeliveryPresenter.h"

@interface BBDeliveryRouter : NSObject <BBDeliveryRouterInput>

@property (weak, nonatomic) BBDeliveryPresenter *presenter;

@end
