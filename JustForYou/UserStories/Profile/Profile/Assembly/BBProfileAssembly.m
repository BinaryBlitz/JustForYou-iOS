#import "BBProfileAssembly.h"

#import "BBProfileViewController.h"
#import "BBProfileInteractor.h"
#import "BBProfilePresenter.h"
#import "BBProfileRouter.h"

@implementation BBProfileAssembly


+ (id <BBProfileModuleInput>)createModule {

    BBProfileViewController *view = [self viewController];

    BBProfileInteractor *interactor = [BBProfileInteractor new];
    BBProfilePresenter *presenter = [BBProfilePresenter new];
    BBProfileRouter *router = [BBProfileRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBProfileViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    BBProfileViewController * vc = (BBProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"BBProfileViewController"];
    return vc;
}

@end
