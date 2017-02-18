#import "BBContainerView.h"

@implementation BBContainerView

- (void)displayView:(id)view
{
    if ([view isKindOfClass:[UIViewController class]])
    {
        UITableViewController* vc = (UITableViewController*)view;
        
        [self.parentVC addChildViewController:vc];
        vc.view.frame = self.bounds;
        [self addSubview:vc.tableView];
        [vc didMoveToParentViewController:self.parentVC];
    }
}

@end
