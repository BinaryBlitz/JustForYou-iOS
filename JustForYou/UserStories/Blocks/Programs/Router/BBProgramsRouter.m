#import "BBProgramsRouter.h"
#import "BBProgramsPresenter.h"
@implementation BBProgramsRouter

#pragma mark - BBProgramsRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  HQDispatchToMainQueue(^{
    [nc pushViewController:vc animated:YES];
  });
}

- (void)presentBasketViewControllerWithController:(UINavigationController *)basketNC
                         withNavigationController:(UINavigationController *)nc {
  HQDispatchToMainQueue(^{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootViewController) name:kNotificationResetBlocks object:nil];
    [nc presentViewController:basketNC animated:YES completion:nil];
  });
}

- (void)popToRootViewController {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  UIViewController *vc = (UIViewController *) self.presenter.view;
  [vc.navigationController popToRootViewControllerAnimated:true];
}

- (void)callManagerOnPhone:(NSString *)phoneManager {
  NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneManager]];
  if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
    [[UIApplication sharedApplication] openURL:phoneUrl];
  } else {
    [self.presenter errorCallManager];
  }
}

@end
