#import "BBListMyProgAssembly.h"

#import "BBListMyProgViewController.h"
#import "BBListMyProgInteractor.h"
#import "BBListMyProgPresenter.h"
#import "BBListMyProgRouter.h"

@implementation BBListMyProgAssembly


+ (id <BBListMyProgModuleInput>)createModule {

    BBListMyProgViewController *view = [self viewController];

    BBListMyProgInteractor *interactor = [BBListMyProgInteractor new];
    BBListMyProgPresenter *presenter = [BBListMyProgPresenter new];
    BBListMyProgRouter *router = [BBListMyProgRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBListMyProgViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    BBListMyProgViewController * vc = (BBListMyProgViewController *)[sb instantiateViewControllerWithIdentifier:@"BBListMyProgViewController"];
    return vc;
}

@end
