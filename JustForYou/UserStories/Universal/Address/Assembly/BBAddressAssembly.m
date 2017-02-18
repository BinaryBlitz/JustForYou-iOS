#import "BBAddressAssembly.h"

#import "BBAddressViewController.h"
#import "BBAddressInteractor.h"
#import "BBAddressPresenter.h"
#import "BBAddressRouter.h"

@implementation BBAddressAssembly


+ (id <BBAddressModuleInput>)createModule {

    BBAddressViewController *view = [self viewController];

    BBAddressInteractor *interactor = [BBAddressInteractor new];
    BBAddressPresenter *presenter = [BBAddressPresenter new];
    BBAddressRouter *router = [BBAddressRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBAddressViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Universal" bundle:nil];
    BBAddressViewController * vc = (BBAddressViewController *)[sb instantiateViewControllerWithIdentifier:@"BBAddressViewController"];
    return vc;
}

@end
