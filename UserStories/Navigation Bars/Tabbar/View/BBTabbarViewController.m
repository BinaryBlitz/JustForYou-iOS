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

@interface BBTabbarViewController()

@end

@implementation BBTabbarViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
    [self.tabBar layoutSubviews];
}

#pragma mark - Методы BBTabbarViewInput

- (void)setupInitialState {
    
}

- (void)presentFirstItem {
    [self setSelectedIndex:0];
}

- (void)setItemsBar:(NSArray *)items {
    self.viewControllers = items;
    self.tabBar.items[0].image = [UIImage imageNamed:@"home"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"orders"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"support"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"profile"];
    
    self.tabBar.items[0].title = kNameTitleProgramModule;
    self.tabBar.items[1].title = kNameTitleOrdersModule;
    self.tabBar.items[2].title = kNameTitleSupportModule;
    self.tabBar.items[3].title = kNameTitleProfileModule;
}

@end