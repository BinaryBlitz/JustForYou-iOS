//
//  BBTabbarViewController.m
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarViewController.h"

#import "BBTabbarViewOutput.h"

#import "BBTabBar.h"

@interface BBTabbarViewController() /*<BBTabbarDelegate>*/

@end

@implementation BBTabbarViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

#pragma mark - Методы BBTabbarViewInput

- (void)setupInitialState {
    
}


- (void)setItemsBar:(NSArray *)items {
    self.viewControllers = items;
    self.tabBar.items[0].image = [UIImage imageNamed:@"Home.pdf"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"Home.pdf"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"Home.pdf"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"Home.pdf"];
    
# warning delete
//    self.tabBar.items[0].title = @"Программы";
//    self.tabBar.items[1].title = @"Заказы";
//    self.tabBar.items[2].title = @"Профиль";
//    self.tabBar.items[3].title = @"Поддержка";
}

//#pragma mark - UITabbarDelegate
//
//- (void)tabBar:(BBTabBar *)tabBar didPressItem:(BBTabbarItem)item
//{
//    if (item == BBTabbarItemPrograms) {
//        [self.output didPressItemPrograms];
//    } else if (item == BBTabbarItemOrders) {
//        [self.output didPressItemOrders];
//    }  else if (item == BBTabbarItemProfile) {
//        [self.output didPressItemProfile];
//    }  else if (item == BBTabbarItemSupport) {
//        [self.output didPressItemSupport];
//    }
//}

@end