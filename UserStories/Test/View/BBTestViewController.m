//
//  BBTestViewController.m
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestViewController.h"

#import "BBTestViewOutput.h"

@implementation BBTestViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBTestViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}

@end