#import "BBBasketViewOutput.h"
#import "BBBasketInteractorOutput.h"
#import "BBBasketModuleInput.h"

@protocol BBBasketViewInput;
@protocol BBBasketInteractorInput;
@protocol BBBasketRouterInput;

@interface BBBasketPresenter : NSObject <BBBasketModuleInput, BBBasketViewOutput, BBBasketInteractorOutput>

@property (strong, nonatomic) id <BBBasketViewInput> view;
@property (strong, nonatomic) id <BBBasketInteractorInput> interactor;
@property (strong, nonatomic) id <BBBasketRouterInput> router;

@end
