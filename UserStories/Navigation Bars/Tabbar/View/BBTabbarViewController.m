//
//  BBTabbarViewController.m
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarViewController.h"

#import "BBTabbarViewOutput.h"
#import "BBContainerView.h"
#import "BBTabBar.h"

@interface BBTabbarViewController()

@property (weak, nonatomic) IBOutlet BBContainerView *containerView;
@property (weak, nonatomic) IBOutlet BBTabBar *tabbar;


@end

@implementation BBTabbarViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBTabbarViewInput

- (void)setupInitialState {
    
    [self.tabbar setSelectedItem:[self.tabbar.items objectAtIndex:TabbarItemPrograms]];
    
    [self.output needInitialViewForContainer];
}

- (void)loadContentWithNavigationController:(id)navigetionView and:(BBLoadModule) keyLoad {
    [self.containerView displayView:navigetionView];
}

@end