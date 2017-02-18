#import "BBNavigationAssembly.h"

#import "BBNavigationViewController.h"
#import "BBNavigationInteractor.h"
#import "BBNavigationPresenter.h"
#import "BBNavigationRouter.h"

@implementation BBNavigationAssembly

+ (id <BBNavigationModuleInput>)createModule {

  BBNavigationViewController *view = [self viewController];

  BBNavigationInteractor *interactor = [BBNavigationInteractor new];
  BBNavigationPresenter *presenter = [BBNavigationPresenter new];
  BBNavigationRouter *router = [BBNavigationRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBNavigationViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  BBNavigationViewController *vc = (BBNavigationViewController *) [sb instantiateViewControllerWithIdentifier:@"BBNavigationViewController"];
  return vc;
}

@end
