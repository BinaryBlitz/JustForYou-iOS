//
//  BBContainerView.m
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBContainerView.h"

@interface BBContainerView ()

@property (weak, nonatomic) UIViewController* currentVC;

@end

@implementation BBContainerView

- (void)displayView:(id)view
{
    if (self.currentVC)
    {
        [self removeCurrentVC];
    }
    
    if ([view isKindOfClass:[UIViewController class]])
    {
        UIViewController* vc = (UIViewController*)view;
        
        [self.parentVC addChildViewController:vc];
        vc.view.frame = self.bounds;
        [self addSubview:vc.view];
        [vc didMoveToParentViewController:self.parentVC];
        self.currentVC = vc;
    }
}

- (void)removeCurrentVC
{
    [self.currentVC willMoveToParentViewController:nil];
    [self.currentVC.view removeFromSuperview];
    self.currentVC = nil;
}


@end
