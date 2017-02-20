#import "BBProgramsAssembly.h"

#import "BBProgramsViewController.h"
#import "BBProgramsInteractor.h"
#import "BBProgramsPresenter.h"
#import "BBProgramsRouter.h"

@implementation BBProgramsAssembly

+ (id <BBProgramsModuleInput>)createModule {

  BBProgramsViewController *view = [self viewController];

  BBProgramsInteractor *interactor = [BBProgramsInteractor new];
  BBProgramsPresenter *presenter = [BBProgramsPresenter new];
  BBProgramsRouter *router = [BBProgramsRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBProgramsViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Blocks" bundle:nil];
  BBProgramsViewController *vc = (BBProgramsViewController *) [sb instantiateViewControllerWithIdentifier:@"BBProgramsViewController"];
  return vc;
}

@end
