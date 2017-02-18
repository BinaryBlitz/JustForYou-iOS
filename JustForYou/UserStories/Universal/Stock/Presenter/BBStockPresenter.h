#import "BBStockViewOutput.h"
#import "BBStockInteractorOutput.h"
#import "BBStockModuleInput.h"

@protocol BBStockViewInput;
@protocol BBStockInteractorInput;
@protocol BBStockRouterInput;

@interface BBStockPresenter : NSObject <BBStockModuleInput, BBStockViewOutput, BBStockInteractorOutput>

@property (strong, nonatomic) id<BBStockViewInput> view;
@property (strong, nonatomic) id<BBStockInteractorInput> interactor;
@property (strong, nonatomic) id<BBStockRouterInput> router;

@end
