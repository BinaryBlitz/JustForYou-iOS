#import "BBOrdersAssembly.h"

#import "BBOrdersViewController.h"
#import "BBOrdersInteractor.h"
#import "BBOrdersPresenter.h"
#import "BBOrdersRouter.h"

@implementation BBOrdersAssembly

+ (id <BBOrdersModuleInput>)createModule {

  BBOrdersViewController *view = [self viewController];

  BBOrdersInteractor *interactor = [BBOrdersInteractor new];
  BBOrdersPresenter *presenter = [BBOrdersPresenter new];
  BBOrdersRouter *router = [BBOrdersRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBOrdersViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Orders" bundle:nil];
  BBOrdersViewController *vc = (BBOrdersViewController *) [sb instantiateViewControllerWithIdentifier:@"BBOrdersViewController"];
  return vc;
}

@end
