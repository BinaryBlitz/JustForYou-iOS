//
//  BBTabBar.m
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTabBar.h"

@implementation BBTabBar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([self.tabbarDelegate respondsToSelector:@selector(tabBar:didPressItem:)])
    {
        NSInteger itemNumber = [tabBar.items indexOfObject:item];
        [self.tabbarDelegate tabBar:self didPressItem:itemNumber];
    }
}

@end
