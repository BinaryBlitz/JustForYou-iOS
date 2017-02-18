#import "BBBasketAssembly.h"

#import "BBBasketViewController.h"
#import "BBBasketInteractor.h"
#import "BBBasketPresenter.h"
#import "BBBasketRouter.h"

@implementation BBBasketAssembly


+ (id <BBBasketModuleInput>)createModule {

    BBBasketViewController *view = [self viewController];

    BBBasketInteractor *interactor = [BBBasketInteractor new];
    BBBasketPresenter *presenter = [BBBasketPresenter new];
    BBBasketRouter *router = [BBBasketRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBBasketViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Blocks" bundle:nil];
    BBBasketViewController * vc = (BBBasketViewController *)[sb instantiateViewControllerWithIdentifier:@"BBBasketViewController"];
    return vc;
}

@end
