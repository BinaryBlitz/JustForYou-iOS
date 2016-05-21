//
//  BBGreetingViewInput.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBGreetingViewInput <NSObject>

- (void)setupInitialState;

- (void)countPageInPageControl:(NSInteger)count;

- (void)changePageInScrollView;

@end