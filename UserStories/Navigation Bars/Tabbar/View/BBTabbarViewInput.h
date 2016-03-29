//
//  BBTabbarViewInput.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol BBTabbarViewInput <NSObject>

- (void)setupInitialState;

- (void)loadContentWithNavigationController:(id)navigetionView and:(BBLoadModule) keyLoad;

- (void)displayView:(id)view;

@end