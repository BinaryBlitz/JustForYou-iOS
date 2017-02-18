#import "BBStockRouterInput.h"

#import "BBStockPresenter.h"

@interface BBStockRouter : NSObject <BBStockRouterInput>

@property (weak, nonatomic) BBStockPresenter *presenter;

@end
