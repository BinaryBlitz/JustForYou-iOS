//
//  BBAuthorizationRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBAuthorizationRouterInput <NSObject>

- (void)presentFromWindow:(UIWindow *)window;

@end