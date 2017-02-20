#import "BBMyProgramsAssembly.h"

#import "BBMyProgramsViewController.h"
#import "BBMyProgramsInteractor.h"
#import "BBMyProgramsPresenter.h"
#import "BBMyProgramsRouter.h"

@implementation BBMyProgramsAssembly

+ (id <BBMyProgramsModuleInput>)createModule {

  BBMyProgramsViewController *view = [self viewController];

  BBMyProgramsInteractor *interactor = [BBMyProgramsInteractor new];
  BBMyProgramsPresenter *presenter = [BBMyProgramsPresenter new];
  BBMyProgramsRouter *router = [BBMyProgramsRouter new];

  router.presenter = presenter;

  view.output = presenter;
  interactor.output = presenter;

  presenter.view = view;
  presenter.interactor = interactor;
  presenter.router = router;
  [presenter configureModule];

  return presenter;
}

+ (BBMyProgramsViewController *)viewController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Orders" bundle:nil];
  BBMyProgramsViewController *vc = (BBMyProgramsViewController *) [sb instantiateViewControllerWithIdentifier:@"BBMyProgramsViewController"];
  return vc;
}

@end
