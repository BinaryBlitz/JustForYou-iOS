#import "BBMapViewOutput.h"
#import "BBMapInteractorOutput.h"
#import "BBMapModuleInput.h"

@protocol BBMapViewInput;
@protocol BBMapInteractorInput;
@protocol BBMapRouterInput;

@interface BBMapPresenter : NSObject <BBMapModuleInput, BBMapViewOutput, BBMapInteractorOutput>

@property (strong, nonatomic) id <BBMapViewInput> view;
@property (strong, nonatomic) id <BBMapInteractorInput> interactor;
@property (strong, nonatomic) id <BBMapRouterInput> router;

@end
