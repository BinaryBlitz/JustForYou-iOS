//
//  BBSupportRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBSupportRouterInput <NSObject>

- (void)presentMailController;

- (void)callManagerOnPhone:(NSString *)phoneManager;

@end