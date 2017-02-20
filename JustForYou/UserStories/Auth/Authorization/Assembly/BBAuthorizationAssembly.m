#import "BBAuthorizationAssembly.h"

#import "BBAuthorizationViewController.h"
#import "BBAuthorizationInteractor.h"
#import "BBAuthorizationPresenter.h"
#import "BBAuthorizationRouter.h"

@implementation BBAuthorizationAssembly

+ (id <BBAuthorizationModuleInput>)createModule {

  BBAuthorizationViewController *view = [self viewController];

  BBAuthorizationInteractor *interactor = [BBAuthorizationInteractor new];
  BBAuthorizationPresenter *presenter = [BBAuthorizationPresenter new];
  BBAuthorizationRouter *router = [BBAuthorizationRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBAuthorizationViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Authorizate" bundle:nil];
  BBAuthorizationViewController *vc = (BBAuthorizationViewController *) [sb instantiateViewControllerWithIdentifier:@"BBAuthorizationViewController"];
  return vc;
}

@end
