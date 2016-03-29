//
//  BBTabBar.h
//  JustForYou
//
//  Created by Антон on 24.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBTabbarDelegate;

@interface BBTabBar : UITabBar <UITabBarDelegate>

@property (weak, nonatomic) id <BBTabbarDelegate> tabbarDelegate;

@end


@protocol BBTabbarDelegate <NSObject>
@optional

- (void)tabBar:(BBTabBar *)tabBar didPressItem:(BBTabbarItem)item;

@end