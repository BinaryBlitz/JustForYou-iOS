//
//  BBContainerView.m
//  JustForYou
//
//  Created by Антон on 02.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

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
