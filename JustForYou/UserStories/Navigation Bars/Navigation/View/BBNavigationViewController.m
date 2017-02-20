#import "BBNavigationViewController.h"

#import "BBNavigationViewOutput.h"

@interface BBNavigationViewController () <UINavigationControllerDelegate>

@end

@implementation BBNavigationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBNavigationViewInput

- (void)setupInitialState {
  self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


@end
