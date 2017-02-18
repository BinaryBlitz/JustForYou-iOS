#import "BBDeliveryInteractorInput.h"

@protocol BBDeliveryInteractorOutput;

@interface BBDeliveryInteractor : NSObject <BBDeliveryInteractorInput>

@property (weak, nonatomic) id<BBDeliveryInteractorOutput> output;

@end
