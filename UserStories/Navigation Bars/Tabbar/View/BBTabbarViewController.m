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


#pragma mark - Методы BBTabbarViewInput

- (void)setupInitialState {
    
}


- (void)setItemsBar:(NSArray *)items {
    self.viewControllers = items;
    self.tabBar.items[0].image = [UIImage imageNamed:@"home"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"orders"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"support"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"profile"];
    
    self.tabBar.items[0].title = @"Программы";
    self.tabBar.items[1].title = @"Заказы";
    self.tabBar.items[2].title = @"Поддержка";
    self.tabBar.items[3].title = @"Профиль";
}

@end