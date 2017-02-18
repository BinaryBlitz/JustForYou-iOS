#import "BBStockAssembly.h"

#import "BBStockViewController.h"
#import "BBStockInteractor.h"
#import "BBStockPresenter.h"
#import "BBStockRouter.h"

@implementation BBStockAssembly


+ (id <BBStockModuleInput>)createModule {

    BBStockViewController *view = [self viewController];

    BBStockInteractor *interactor = [BBStockInteractor new];
    BBStockPresenter *presenter = [BBStockPresenter new];
    BBStockRouter *router = [BBStockRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBStockViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Universal" bundle:nil];
    BBStockViewController * vc = (BBStockViewController *)[sb instantiateViewControllerWithIdentifier:@"BBStockViewController"];
    return vc;
}

@end
