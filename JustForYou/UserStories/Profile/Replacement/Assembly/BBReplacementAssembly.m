#import "BBReplacementAssembly.h"

#import "BBReplacementViewController.h"
#import "BBReplacementInteractor.h"
#import "BBReplacementPresenter.h"
#import "BBReplacementRouter.h"

@implementation BBReplacementAssembly

+ (id <BBReplacementModuleInput>)createModule {

  BBReplacementViewController *view = [self viewController];

  BBReplacementInteractor *interactor = [BBReplacementInteractor new];
  BBReplacementPresenter *presenter = [BBReplacementPresenter new];
  BBReplacementRouter *router = [BBReplacementRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBReplacementViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
  BBReplacementViewController *vc = (BBReplacementViewController *) [sb instantiateViewControllerWithIdentifier:@"BBReplacementViewController"];
  return vc;
}

@end
