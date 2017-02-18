#import "BBReplaceProgramAssembly.h"

#import "BBReplaceProgramViewController.h"
#import "BBReplaceProgramInteractor.h"
#import "BBReplaceProgramPresenter.h"
#import "BBReplaceProgramRouter.h"

@implementation BBReplaceProgramAssembly


+ (id <BBReplaceProgramModuleInput>)createModule {

    BBReplaceProgramViewController *view = [self viewController];

    BBReplaceProgramInteractor *interactor = [BBReplaceProgramInteractor new];
    BBReplaceProgramPresenter *presenter = [BBReplaceProgramPresenter new];
    BBReplaceProgramRouter *router = [BBReplaceProgramRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    [presenter configureModule];
    
    return presenter;
}

+ (BBReplaceProgramViewController *)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    BBReplaceProgramViewController * vc = (BBReplaceProgramViewController *)[sb instantiateViewControllerWithIdentifier:@"BBReplaceProgramViewController"];
    return vc;
}

@end
