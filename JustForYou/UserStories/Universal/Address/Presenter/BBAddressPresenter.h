#import "BBAddressViewOutput.h"
#import "BBAddressInteractorOutput.h"
#import "BBAddressModuleInput.h"

@protocol BBAddressViewInput;
@protocol BBAddressInteractorInput;
@protocol BBAddressRouterInput;

@interface BBAddressPresenter : NSObject <BBAddressModuleInput, BBAddressViewOutput, BBAddressInteractorOutput>

@property (strong, nonatomic) id <BBAddressViewInput> view;
@property (strong, nonatomic) id <BBAddressInteractorInput> interactor;
@property (strong, nonatomic) id <BBAddressRouterInput> router;

@end
