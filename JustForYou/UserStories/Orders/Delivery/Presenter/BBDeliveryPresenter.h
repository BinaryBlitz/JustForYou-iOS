#import "BBDeliveryViewOutput.h"
#import "BBDeliveryInteractorOutput.h"
#import "BBDeliveryModuleInput.h"

@protocol BBDeliveryViewInput;
@protocol BBDeliveryInteractorInput;
@protocol BBDeliveryRouterInput;

@interface BBDeliveryPresenter : NSObject <BBDeliveryModuleInput, BBDeliveryViewOutput, BBDeliveryInteractorOutput>

@property (strong, nonatomic) id <BBDeliveryViewInput> view;
@property (strong, nonatomic) id <BBDeliveryInteractorInput> interactor;
@property (strong, nonatomic) id <BBDeliveryRouterInput> router;

@end
