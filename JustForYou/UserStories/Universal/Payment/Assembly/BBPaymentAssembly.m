#import "BBPaymentAssembly.h"

#import "BBPaymentViewController.h"
#import "BBPaymentInteractor.h"
#import "BBPaymentPresenter.h"
#import "BBPaymentRouter.h"

@implementation BBPaymentAssembly

+ (id <BBPaymentModuleInput>)createModule {

  BBPaymentViewController *view = [self viewController];

  BBPaymentInteractor *interactor = [BBPaymentInteractor new];
  BBPaymentPresenter *presenter = [BBPaymentPresenter new];
  BBPaymentRouter *router = [BBPaymentRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBPaymentViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Universal" bundle:nil];
  BBPaymentViewController *vc = (BBPaymentViewController *) [sb instantiateViewControllerWithIdentifier:@"BBPaymentViewController"];
  return vc;
}

@end
