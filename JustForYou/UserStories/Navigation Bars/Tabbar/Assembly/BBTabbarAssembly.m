#import "BBTabbarAssembly.h"

#import "BBTabbarViewController.h"
#import "BBTabbarInteractor.h"
#import "BBTabbarPresenter.h"
#import "BBTabbarRouter.h"

@implementation BBTabbarAssembly

+ (id <BBTabbarModuleInput>)createModule {
  BBTabbarViewController *view = [self viewController];

  BBTabbarInteractor *interactor = [BBTabbarInteractor new];
  BBTabbarPresenter *presenter = [BBTabbarPresenter new];
  BBTabbarRouter *router = [BBTabbarRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBTabbarViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  BBTabbarViewController *vc = (BBTabbarViewController *) [sb instantiateViewControllerWithIdentifier:@"BBTabbarViewController"];
  return vc;
}

@end
